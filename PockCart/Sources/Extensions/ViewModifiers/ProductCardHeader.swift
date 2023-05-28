//
//  ProductCardHeader.swift
//  PockCart
//
//  Created by Youssef ZITAN on 28/05/2023.
//

import SwiftUI

struct ProductCardHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 5)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .background(.red)
    }
}

extension View {
    func productCardHeader() -> some View {
        modifier(ProductCardHeader())
    }
}
