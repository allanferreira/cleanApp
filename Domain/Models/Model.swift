//
//  Model.swift
//  Domain
//
//  Created by Macbook on 14/11/20.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

