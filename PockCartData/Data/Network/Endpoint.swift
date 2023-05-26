//
//  Endpoint.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 25/05/2023.
//

import Foundation
import Combine

public struct APIPath {
    static let baseUrl = ""

    static let products = "products"
}

public enum APIError: Error {
    /// If we are unable to build the request
    case invalidRequest
    /// The response format could not be decoded into the expected type
    case decodingError
    /// If jwt token has expired or not valid
    case unauthorized
    /// The request could not be made (due to a timeout, missing connectivity, offline, etc).
    case networkConnectionError
    /// The server return an error with a status code
    case serverError(Int)
    case customError(Error)
    case unknown
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}

public protocol HTTPBody {
    var isEmpty: Bool { get }
    var additionalHeaders: [String: String] { get }
    func encode() throws -> Data
}

public extension HTTPBody {
    var isEmpty: Bool {
        return false
    }

    var additionalHeaders: [String: String] {
        return [:]
    }
}

public struct EmptyBody: HTTPBody {
    public let isEmpty = true

    public init() {
        // As there is no Body, the init is empty
    }

    public func encode() throws -> Data {
        Data()
    }
}

public struct DataBody: HTTPBody {
    public var isEmpty: Bool { data.isEmpty }
    public var additionalHeaders: [String: String]

    private let data: Data

    public init(_ data: Data, additionalHeaders: [String: String] = [:]) {
        self.data = data
        self.additionalHeaders = additionalHeaders
    }

    public func encode() throws -> Data {
        data
    }
}

public struct JSONBody: HTTPBody {
    public let isEmpty: Bool = false
    public let additionalHeaders = [HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue]

    private let encoding: () throws -> Data

    public init<T: Encodable>(_ value: T, encoder: JSONEncoder = JSONEncoder()) {
        self.encoding = { try encoder.encode(value) }
    }

    public func encode() throws -> Data {
        try encoding()
    }
}

struct Endpoint<Kind: EndpointKind, Response> {
    /// Some backend services are public and have a different base URL that not depends on environment.
    /// If this value is specified we must use this instead of the base url from remote config
    var baseURL: String?
    var method: HTTPMethod
    var path: String
    var queryItems = [URLQueryItem]()
    var body: HTTPBody = EmptyBody()
    var parse: (Data) throws -> Response
}

extension Endpoint where Response: Decodable {
    init(baseURL: String? = nil,
         method: HTTPMethod = .get,
         path: String,
         queryItems: [URLQueryItem] = [URLQueryItem](),
         body: HTTPBody = EmptyBody(),
         decoder: JSONDecoder = .init()) {

        self.init(baseURL: baseURL,
                  method: method,
                  path: path,
                  queryItems: queryItems,
                  body: body) { data -> Response in
            do {
                return try decoder.decode(Response.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        }
    }
}

extension Endpoint where Response == Void {
    init(baseURL: String? = nil,
         method: HTTPMethod = .get,
         path: String,
         queryItems: [URLQueryItem] = [URLQueryItem](),
         body: HTTPBody = EmptyBody()) {

        self.init(baseURL: baseURL,
                  method: method,
                  path: path,
                  queryItems: queryItems,
                  body: body) { _ -> Response in () }
    }
}

extension Endpoint {
    func makeRequest(with data: Kind.RequestData) -> URLRequest? {
        let currentBaseURL = baseURL ?? APIPath.baseUrl
        var components = URLComponents(string: currentBaseURL)
        components?.path += "/" + path
        components?.queryItems = queryItems.isEmpty ? nil : queryItems

        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back:
        guard let url = components?.url else {
            return nil
        }

        let timeoutInterval = 30.0
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue

        if body.isEmpty == false {
            // if our body defines additional headers, add them
            for (header, value) in body.additionalHeaders {
                request.addValue(value, forHTTPHeaderField: header)
            }

            // attempt to retrieve the body data
            request.httpBody = try? body.encode()
        }

        Kind.prepare(&request, with: data)
        return request
    }
}

// MARK: - Endpoint kind

protocol EndpointKind {
    associatedtype RequestData
    static func prepare(_ request: inout URLRequest, with data: RequestData)
}

enum EndpointKinds {
    enum Public: EndpointKind {
        static func prepare(_ request: inout URLRequest, with _: Void) {
            request.cachePolicy = .reloadIgnoringLocalCacheData
        }
    }

   /* enum Protected: EndpointKind {
        static func prepare(_ request: inout URLRequest, with token: String?) {
            if let token = token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: MPKeyConstant.authorization)
            } else {
                request.cachePolicy = .reloadIgnoringLocalCacheData
            }
        }
    }*/

}

extension URLSession {
    func publisher<K, R>(for endpoint: Endpoint<K, R>,
                         using requestData: K.RequestData) -> AnyPublisher<R, APIError> {

        guard let request = endpoint.makeRequest(with: requestData) else {
            return Fail(error: .invalidRequest).eraseToAnyPublisher()
        }

        return dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode != 401 else {
                    throw APIError.unauthorized
                }

                guard 200...204 ~= response.statusCode else {
                    throw APIError.serverError(response.statusCode)
                }

                return output.data
            }
            .tryMap { try endpoint.parse($0) }
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else if let urlError = error as? URLError,
                          urlError.code == URLError.Code.notConnectedToInternet {
                    return APIError.networkConnectionError
                } else {
                    return APIError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}




