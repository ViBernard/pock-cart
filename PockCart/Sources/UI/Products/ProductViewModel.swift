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


final class ProductViewModel: LoadableViewModel, ObservableObject {

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

            case .finished:
                self?.state = .finishedLoading
           
            }
        }

        let valueHandler: ([Product]) -> Void = { [weak self] products in
            self?.products = products
        }

        fetchProductsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: completionHandler,
                  receiveValue: valueHandler)
            .store(in: &subscriptions)

    }

}

