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
            LazyVStack {
                ForEach((viewModel.products), id: \.self) { item in
                    ProductCardBlocView(product: item)
                        .environmentObject(viewModel)
                }
            }
        }
        .padding([.trailing, .leading], 20)
        .onAppear(perform: viewModel.fetchProducts)
    }
}

struct ProductCardBlocView: View {

    var product:Product
    
    var body: some View {
        VStack (alignment: .leading, content: {
            ProductCardHeaderView(name: product.name)
            ProductCardInfosView(
                description: product.description,
                labels: product.labels
            )
            if(product.hasPromo) {
                ProductCardPromotionView()
            }
            ProductCardPriceView(
                priceLabel: product.price,
                pricePromo: product.pricePromo
            )
        })
        .cornerRadius(5) /// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(.lightGray), lineWidth: 1))
    }
}

struct ProductCardHeaderView: View {

    var name: String

    var body: some View {
        Text(name)
            .productCardHeader()
    }
}

struct ProductCardInfosView: View {

    var description:String
    var labels: [String]
    
    var body: some View {
        HStack(alignment: .center, spacing: 5, content:  {
            Image("kitkat")
                .padding(.vertical,5)
            VStack(alignment: .leading, spacing: 10, content: {
                HStack {
                    ForEach(labels, id: \.self) { label in
                        Text(label)
                            .productCardTag()
                    }
                }
                Text(self.description)
                    .lineLimit(3)
                    .padding(Edge.Set.trailing,20)
                    .bold()
                    .font(Font(CTFont(.label, size: 12)))
            })
        })
    }
}

struct ProductCardPriceView: View {

    var priceLabel: String
    var pricePromo: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, content: {
                Text(pricePromo ?? priceLabel)
                    .bold()
                    .font(Font(CTFont(.label, size: 12)))
                if(pricePromo != nil) {
                    Text(priceLabel)
                        .font(Font(CTFont(.label, size: 11)))
                        .foregroundColor(Color("grey900"))
                }
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
            .productCardPromotion()
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
