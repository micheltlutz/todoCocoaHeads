//
//  ApiUrl.swift
//  LuvPet
//
//  Created by Michel Anderson Lutz Teixeira on 28/06/2018.
//  Copyright © 2018 Michel Anderson Lutz Teixeira. All rights reserved.
//

import Foundation

protocol ApiURLProtocol{
    var url: String { get }
}

enum ApiURL {
    private static let base = "http://192.168.1.140:8080/"
    //private static let base = "http://192.168.1.149:8080/"
    enum Todos: String, ApiURLProtocol {
        case todo = "todos/"

//        enum Reminder: String, ApiURLProtocol {
//            case new = "/novo/"
//            var url: String {
//                return ApiURL.Pets.reminder.url + self.rawValue
//            }
//        }
        var url: String {
            return ApiURL.base + self.rawValue
        }
    }
}
