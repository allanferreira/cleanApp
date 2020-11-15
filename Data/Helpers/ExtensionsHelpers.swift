//
//  ExtensionsHelpers.swift
//  Data
//
//  Created by Macbook on 14/11/20.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}