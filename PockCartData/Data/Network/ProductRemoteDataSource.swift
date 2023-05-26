//
//  ProductDataSource.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation
import Combine

extension Endpoint where Kind == EndpointKinds.Public, Response == ProductsDTO {
    static func getProducts() -> Self {
        return Endpoint(method: .get,
                        path: APIPath.products)
    }
}

struct ProductRemoteDataSource {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Lifecycle

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Methods

    func fetchProducts() -> AnyPublisher<ProductsDTO, APIError> {
        session.publisher(for: .getProducts(),
                          using: ())
    }

}

