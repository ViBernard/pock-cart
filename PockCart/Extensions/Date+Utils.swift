//
//  Date+Utils.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation

@propertyWrapper
struct NilableDateWrapper: Decodable {
    var wrappedValue: Date?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self),
           let date = value.convertToApiDate() {
            wrappedValue = date
        }
    }
}

@propertyWrapper
struct DateWrapper: Decodable {
    var wrappedValue: Date = Date()

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self),
           let date = value.convertToApiDate() {
            wrappedValue = date
        }
    }
}
