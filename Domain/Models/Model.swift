//
//  Model.swift
//  Domain
//
//  Created by Macbook on 14/11/20.
//

import Foundation

public protocol Model: Encodable{}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

