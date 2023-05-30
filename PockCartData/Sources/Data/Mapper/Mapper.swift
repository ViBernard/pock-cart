//
//  Mapper.swift
//  PockCart
//
//  Created by vivien bernard on 26/05/2023.
//

import Foundation

protocol Mapper {
    associatedtype T
    associatedtype U

    static func convert(from entity: T) -> U
    static func convert(from entities: [T]) -> [U]

}

extension Mapper {
    static func convert(from entities: [T]) -> [U] {
        entities.map { Self.convert(from:$0) }
    }
}
