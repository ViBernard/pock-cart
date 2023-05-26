//
//  FetchProductsUseCase.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 25/05/2023.
//

import Foundation
import Combine

public protocol FetchProductsUseCase {
    func execute() -> AnyPublisher<[Product], APIError>
}

final class FetchProductsUseCaseImpl: FetchProductsUseCase {

    private let productRepositories: ProductsRepository

    init(productRepositories: ProductsRepository) {
        self.productRepositories = productRepositories
    }

    public func execute() -> AnyPublisher<[Product], APIError> {
        productRepositories.getProducts()
    }
}
