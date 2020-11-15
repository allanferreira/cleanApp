//
//  TestFactories.swift
//  DataTests
//
//  Created by Macbook on 15/11/20.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("any_invalid_data".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://new-any-url.com")!
}
