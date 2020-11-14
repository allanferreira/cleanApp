//
//  HttpPostClient.swift
//  Data
//
//  Created by Macbook on 14/11/20.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void)
}
