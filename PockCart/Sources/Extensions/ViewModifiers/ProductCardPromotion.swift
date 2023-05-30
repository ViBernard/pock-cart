//
//  ViewModifier.swift
//  PockCart
//
//  Created by Youssef ZITAN on 28/05/2023.
//

import SwiftUI

struct ProductCardPromotion: ViewModifier {
    func body(content: Content) -> some View {
        content
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
    }
}

extension View {
    func productCardPromotion() -> some View {
        modifier(ProductCardPromotion())
    }
}
