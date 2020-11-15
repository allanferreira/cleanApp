//
//  HttpError.swift
//  Data
//
//  Created by Macbook on 14/11/20.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
