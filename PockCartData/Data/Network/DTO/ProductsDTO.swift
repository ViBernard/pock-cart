//
//  ProductsDTO.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation

public struct ProductsDTO: Decodable {
    let products: [ProductDTO]

   /* func apiDataConverter() -> [Product] {
        self.products.map{ $0.apiDataConverter() }
    }*/
}
