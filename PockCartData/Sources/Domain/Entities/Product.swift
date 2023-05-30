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
    public let description: String
    public let labels: [String]
    public let hasPromo: Bool
    public let price: String
    public let pricePromo: String?
}

extension Product: Mapper {
    typealias T = ProductDTO
    typealias U = Self

    static func convert(from entity: ProductDTO) -> Product {
        Product(
            id: String(entity.nid),
            name: entity.name,
            description: entity.description ?? "",
            labels: entity.tags ?? [],
            hasPromo: entity.hasPromo ?? false,
            price: String(format:"%.2f €", Double(entity.price)/100.0),
            pricePromo: (entity.hasPromo ?? false) ?
            String(format:"%.2f €", 0.8 * Double(entity.price)/100.0) :
                nil
        )
    }

}
