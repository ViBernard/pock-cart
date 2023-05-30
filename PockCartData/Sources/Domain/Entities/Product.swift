//
//  Product.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation

public struct Product: Identifiable, Hashable {
    public let id: String
    public let name: String
}

extension Product: Mapper {
    typealias T = ProductDTO
    typealias U = Self

    static func convert(from entity: ProductDTO) -> Product {
        Product(id: String(entity.nid), name: entity.name)
    }

}
