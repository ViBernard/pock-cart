//
//  ProductRepositories.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation
import Combine

public struct ProductsRepository {

    // MARK: - Properties

    // TODO : Passer par une interface
    private let remoteDataSource: ProductRemoteDataSource

    // MARK: - Lifecycle

    init(remoteDataSource: ProductRemoteDataSource = .init()) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - Methods

    func getProducts<T: Mapper>() -> AnyPublisher<[T], APIError>
    where T.T == ProductDTO, T.U == T
    {
        remoteDataSource
            .fetchProducts()
            .map { response -> [T] in
                T.convert(from: response.products)
            }
            .eraseToAnyPublisher()
    }

}
