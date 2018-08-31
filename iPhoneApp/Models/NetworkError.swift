//
//  NetworkError.swift
//  Cingulo
//
//  Created by Michel Anderson Lutz Teixeira on 18/04/2018.
//  Copyright © 2018 Codigo da Mente Edicao E Comercio De Livros E Testes. All rights reserved.
//

import Foundation

struct NetworkError{
    enum statusCodes {
        case noConnection
        case timeout
        case badRequest
    }
    let msg: String
    let statusCode: Int
}
