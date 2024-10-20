//
//  TableViewModell.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 17.10.2024.
//

import Foundation

class TableViewModel {
    private var networkManager = NetworkManager(with: .default)
    
    func fetchData() async throws -> [Product] {
        return try await networkManager.fetchData()
    }
}
