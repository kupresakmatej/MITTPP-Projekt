//
//  NetworkingService.swift
//  GoonsTracker
//
//  Created by Matej Kuprešak on 09.12.2023..
//

import Foundation
import SwiftUI

protocol NetworkingServiceProtocol {
    func fetchResponse<T: Codable>(of type: T.Type, with request: Request, completion: @escaping (Result<T, ErrorHandler>) -> Void) where T: Codable
    
    func fetchDefaultResponse(completion: @escaping (Result<LocationReport, ErrorHandler>) -> Void)
}

final class NetworkingService: ObservableObject, NetworkingServiceProtocol {
    func fetchResponse<T>(of type: T.Type, with request: Request, completion: @escaping (Result<T, ErrorHandler>) -> Void) where T : Decodable, T : Encodable {
        guard let urlRequest = configureRequest(request) else { return }
        let urlSession: URLSession = URLSession.shared

        // Create a data task
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }

            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                if let data = data {
                    // Parse data
                    do {
                        let jsonObject = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(jsonObject))
                    } catch {
                        print("Error: \(error)")
                        completion(.failure(.cannotParse))
                        return
                    }
                }
            } else {
                print("Error: \(httpResponse.statusCode)")
                completion(.failure(.notFound))
            }
        }
        .resume()
    }

    
    func fetchDefaultResponse(completion: @escaping (Result<LocationReport, ErrorHandler>) -> Void) {
        let request = Request(
            path: "/api",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil
        )
        
        fetchResponse(of: LocationReport.self, with: request) { result in
            switch result {
            case .success(let response):
                print("SUCCESS")
                completion(.success(response))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}

extension NetworkingService {
    func configureRequest(_ request: Request) -> URLRequest? {
        let configuration: NetworkConfiguration = NetworkConfiguration(baseURL: "https://tarkovpal.com")
        let urlString = configuration.baseURL + request.path
        
        guard let url = URL(string: urlString) else {
            print("Error creating request URL with: \(urlString)")
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(request.type.rawValue, forHTTPHeaderField: "Content-Type")
        
        //headers
        if let headers = configuration.staticHeaders {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        //auth header
        if let authorization = configuration.authorizationHeaders {
            for (key, value) in authorization {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        //paramaters and query
        if let parameters = request.parameters {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                urlRequest.httpBody = jsonData
            }
        }
        
        if let query = request.query {
            urlRequest.url = URL(string: urlString.appending(query))
        }
        
        return urlRequest
    }
}
