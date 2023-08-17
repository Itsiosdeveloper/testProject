//
//  ViewModel.swift
//  testLascade
//
//  Created by SMH on 12/08/23.
//

import Foundation
import UIKit

// ViewModel
class ViewModel {
    var items: [Item] = []

    func fetchData(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://test.lascade.com/api/test/list") else {
            completion()
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion()
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Item.self, from: data)
                self?.items = [decodedData] // This line is changed from decodedData.result
                completion()
            } catch {
                completion()
            }
        }.resume()
    }
}
