//
//  ProductDTO.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation

public struct ProductDTO: Decodable {

    let nid: Int
    let name: String
    let description: String?
    let tags: [String]?
    let hasPromo: Bool?
    let price: Int

    enum CodingKeys: String, CodingKey {
        case nid = "node_id"
        case name
        case description
        case tags
        case hasPromo = "has_promo"
        case price
    }
    
}
