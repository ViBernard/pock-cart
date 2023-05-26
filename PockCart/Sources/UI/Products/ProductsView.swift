//
//  ProductsView.swift
//  PockCart
//
//  Created by vivien bernard on 26/05/2023.
//

import SwiftUI
import PockCartData
import Combine

struct ProductsView: View {

    @StateObject var viewModel: ProductViewModel
    

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
            .onAppear(perform: viewModel.fetchProducts)
    }

}

struct ProductsView_Previews: PreviewProvider {


    struct FakeUseCase: FetchProductsUseCase {
        func execute() -> AnyPublisher<[PockCartData.Product], PockCartData.APIError> {
            Empty(completeImmediately: false).eraseToAnyPublisher()
        }


    }

    static var previews: some View {
        ProductsView(
            viewModel: ProductViewModel(
                fetchProductsUseCase: FakeUseCase()
            )
        )
    }
}
