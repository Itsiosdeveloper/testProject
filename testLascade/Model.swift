//
//  Model.swift
//  testLascade
//
//  Created by SMH on 12/08/23.
//

import Foundation
import UIKit

// Model
struct Item: Codable {
    let status: Bool
    let message: String
    let result: [Result]
}

// MARK: - Result
struct Result: Codable {
    let title, description: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title, description
        case imageURL = "image-url"
    }
}
