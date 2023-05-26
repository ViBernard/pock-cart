//
//  ProductUseCaseDIContainer.swift
//  PockCartData
//
//  Created by vivien bernard on 26/05/2023.
//

import Foundation

public struct ProductUseCaseDIContainer {
    public func makeFetchProductUseCase() -> FetchProductsUseCase {
        FetchProductsUseCaseImpl.init(productRepositories: makeProductRepository())
    }

    func makeProductRepository() -> ProductsRepository {
        ProductsRepository.init()
    }
}
