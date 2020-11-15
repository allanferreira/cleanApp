//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Macbook on 15/11/20.
//

import Foundation
import Domain

func makeAccount() -> AccountModel {
    return AccountModel(id: "any_id", name: "any_name", email: "any@any.com", password: "any123")
}
