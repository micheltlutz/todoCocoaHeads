//
//  TodoViewModel.swift
//  iPhoneApp
//
//  Created by Michel Anderson Lutz Teixeira on 18/08/2018.
//

import Foundation

class TodoViewModel {
    private let todoApi = TodoApi()
    private var todo: Todo?
    var didLoad: ((_ todo: [Todo]) -> Void)?
    var didUpdateTodo: ((_ todo: Todo) -> Void)?
    
    init() {
        list()
    }
    func add(title: String) {
        let todo = Todo(title: title)
        todoApi.new(todo: todo) { (response) in
            switch response {
            case .success(let model):
                self.didUpdateTodo?(model)
            case .networkError(let description):
                print("Error: \(description)")
            case .invalidJSON(let description):
                print("invalidJSON: \(description)")
            }
        }
    }
    func list() {
        todoApi.all { (response) in
            switch response {
            case .success(let model):
                self.didLoad?(model)
            case .networkError(let description):
                print("Error: \(description)")
            }
        }
    }
}
