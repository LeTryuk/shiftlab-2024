//
//  Product.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 18.10.2024.
//

import Foundation

struct Product: Codable, Hashable {
    let id: Int
    let title: String
    let price: Float
}
