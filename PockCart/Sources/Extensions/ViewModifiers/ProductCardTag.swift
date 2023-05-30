//
//  ProductCardTag.swift
//  PockCart
//
//  Created by Youssef ZITAN on 28/05/2023.
//

import SwiftUI

struct ProductCardTag: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font(CTFont(.label, size: 11)))
            .padding(.all, 3)
            .background(Color("grey100"))
            .cornerRadius(4)
    }
}

extension View {
    func productCardTag() -> some View {
        modifier(ProductCardTag())
    }
}
