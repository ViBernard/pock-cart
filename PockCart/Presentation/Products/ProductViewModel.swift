//
//  ProductViewModel.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 25/05/2023.
//

import Foundation
import PockCartData

import Combine

enum LoadableState {
    case idle
    case loading
    case finishedLoading
    case error(Error)
    case noResult
}

class LoadableViewModel {
    @Published var state: LoadableState = .idle
}


final class ProductViewModel: LoadableViewModel {

    // MARK: - Properties

    private var subscriptions = Set<AnyCancellable>()
    private let fetchProductsUseCase: FetchProductsUseCase

    // MARK: Output

    @Published private(set) var products = [Product]()

    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
        super.init()
    }

    func fetchProducts() {

        state = .loading

        let completionHandler: (Subscribers.Completion<APIError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):

                self?.state = .error(error)
                self?.state = .idle
            case .finished:
                self?.state = .finishedLoading
                self?.state = .idle
            }
        }

        let valueHandler: ([Product]) -> Void = { [weak self] products in
            self?.products = products
        }

        fetchProductsUseCase.execute()
            .sink(receiveCompletion: completionHandler,
                  receiveValue: valueHandler)
            .store(in: &subscriptions)

    }

}

