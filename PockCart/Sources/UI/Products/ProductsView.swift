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
        ScrollView {
            // ForEach
            ProductCardBlocView()
                .environmentObject(viewModel)
            ProductCardBlocView()
            ProductCardBlocView()
            ProductCardBlocView()
            ProductCardBlocView()
        }
        .padding([.trailing, .leading], 20)
        .onAppear(perform: viewModel.fetchProducts)
    }
}

struct ProductCardBlocView: View {
    var body: some View {
        LazyVStack (alignment: .leading, content: {
            ProductCardHeaderView()
            ProductCardInfosView()
            ProductCardPromotionView()
            ProductCardPriceView()
        })
        .cornerRadius(5) /// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 1))
    }
}

struct ProductCardHeaderView: View {
    var body: some View {
        Text("Promotion")
            .padding(.all, 5)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .background(.red)
    }
}

struct ProductCardInfosView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 5, content:  {
            Image("kitkat")
            VStack(alignment: .leading, spacing: 5, content: {
                HStack {
                    Text("4 unités")
                        .font(Font(CTFont(.label, size: 11)))
                        .padding(.all, 3)
                        .background(Color("grey100"))
                        .cornerRadius(4)
                    Text("700g")
                        .font(Font(CTFont(.label, size: 11)))
                        .padding(.all, 3)
                        .background(Color("grey100"))
                        .cornerRadius(4)
                }
                Text("MARQUE 75 caractères quise nostrud exercitation ullamco, République dominicaine 700g...")
                    .bold()
                    .font(Font(CTFont(.label, size: 12)))
            })
        })
    }
}

struct ProductCardPriceView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, content: {
                Text("999,99 €")
                    .bold()
                    .font(Font(CTFont(.label, size: 12)))
                Text("999,99 €")
                    .font(Font(CTFont(.label, size: 11)))
                    .foregroundColor(Color("grey900"))
            })
            Spacer()
            ProductCardActionsView()
        }
        .padding([.trailing, .leading, .bottom], 15)
    }
}

struct ProductCardActionsView: View {
    var body: some View {
        HStack {
            Button {
            } label: {
                Image("list")
            }
            
            Button {
            } label: {
                Image("basket")
            }
        }
    }
}

struct ProductCardPromotionView: View {
    var body: some View {
        Text("20 % en € CarteU")
            .padding(.all, 5)
            .frame(maxWidth: .infinity)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .bold()
            .font(Font(CTFont(.label, size: 13)))
            .cornerRadius(5) /// make the background rounded
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.red, lineWidth: 1))
            .padding([.trailing, .leading, .bottom], 15)
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

