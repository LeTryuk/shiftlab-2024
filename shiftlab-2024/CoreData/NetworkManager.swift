//
//  NetworkManager.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 20.10.2024.
//

import Foundation

class NetworkManager {
    private let session: URLSession

    lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()

    init(with sessionConfiguration: URLSessionConfiguration) {
        session = URLSession(configuration: sessionConfiguration)
    }

    func fetchData() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return [] }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let responseData = try await session.data(for: urlRequest)
        
        return try jsonDecoder.decode([Product].self, from: responseData.0)
    }
}


