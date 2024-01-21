//
//  NetworkConfiguration.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.12.2023..
//

import Foundation

struct NetworkConfiguration {
    let baseURL: String
    let staticHeaders: [String: String]? = nil
    let authorizationHeaders: [String: String]? = nil
}

enum HTTPMethod: String {
    case get = "get"
    case post = "post"
}

enum RequestType: String {
    case json = "Application/json; charset=utf-8"
    case query = "Application/w-xxx-form-urlencoded; charset=utf-8"
}

struct Request {
    let path: String
    let method: HTTPMethod
    let type: RequestType
    let parameters: [String: Any]?
    let query: String?
}

enum ErrorHandler: Error {
    case cannotParse
    case notFound
    case other(Int)
    
    init(code: Int) {
        switch code {
        case 404: self = .notFound
        default: self = .other(code)
        }
    }
}
