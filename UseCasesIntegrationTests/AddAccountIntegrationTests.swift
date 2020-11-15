//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Macbook on 15/11/20.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {

    func test_add_account() {
        let httpClient = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: httpClient)
        let addAccount = AddAccountModel(name: "Allan Ferreira", email: "allan@allan.com", password: "secret123", passwordConfirmation: "secret123")
        let exp = expectation(description: "waiting")
        sut.add(addAccount: addAccount) { result in
            switch result {
            case .failure: XCTFail("Expect success but got \(result)")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.name, addAccount.name)
                XCTAssertEqual(account.email, addAccount.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }


}
