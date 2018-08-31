//
//  TodoApi.swift
//  iPhoneApp
//
//  Created by Michel Anderson Lutz Teixeira on 18/08/2018.
//

import Foundation

class TodoApi: Network {
    
    func all(completion: @escaping(_ response: TodosResponse) -> Void) {
        request(url: ApiURL.Todos.todo.url, method: .get, useToken: false).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result{
            case .success(let value):
                if statusCode == 200 {
                    let model = try! self.jsonDecoder.decode([Todo].self, from: response.data!)
                    completion(.success(model: model))
                } else {
                    let err = [["Err-TodoApi-all": value]]
                    completion(.networkError(description: self.error(statusCode: statusCode, responseValue: err)))
                }
            case .failure(let error):
                let erro = NetworkError(msg: error.localizedDescription, statusCode: error._code)
                completion(.networkError(description: erro))
            }//Switch
        }
    }
    
    func new(todo: Todo, completion: @escaping(_ response: TodoResponse) -> Void){
        do {
            let jsonData = try jsonEncoder.encode(todo.self)
            request(url: ApiURL.Todos.todo.url, method: .post, body: jsonData, useToken: false).responseJSON { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                switch response.result{
                case .success(let value):
                    if statusCode == 200 {
                        let model = try! self.jsonDecoder.decode(Todo.self, from: response.data!)
                        completion(.success(model: model))
                    } else {
                        let err = [["Err-TodoApi-new": value]]
                        completion(.networkError(description: self.error(statusCode: statusCode, responseValue: err)))
                    }
                case .failure(let error):
                    let erro = NetworkError(msg: error.localizedDescription, statusCode: error._code)
                    completion(.networkError(description: erro))
                }//Switch
            }
        } catch {
            completion(.invalidJSON(description: self.defaultJsonError))
        }
    }
}
