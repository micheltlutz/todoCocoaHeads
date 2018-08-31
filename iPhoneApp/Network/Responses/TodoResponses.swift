//
//  TodoResponses.swift
//  iPhoneApp
//
//  Created by Michel Anderson Lutz Teixeira on 18/08/2018.
//

import Foundation

enum TodosResponse {
    case success(model: [Todo])
    case networkError(description: NetworkError)
}

enum TodoResponse {
    case success(model: Todo)
    case networkError(description: NetworkError)
    case invalidJSON(description: JSONError)
}
