//
//  Product.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation

public struct Product {
    let identifier: String
    let name: String
}

extension Product: Mapper {
    typealias T = ProductDTO
    typealias U = Self

    static func convert(from entity: ProductDTO) -> Product {
        Product(identifier: String(entity.nid), name: entity.name)
    }

}
