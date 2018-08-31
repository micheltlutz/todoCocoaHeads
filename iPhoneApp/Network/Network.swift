//
//  Network.swift
//  LuvPet
//
//  Created by Michel Anderson Lutz Teixeira on 09/07/2018.
//  Copyright © 2018 Michel Anderson Lutz Teixeira. All rights reserved.
//

import Alamofire
/*
 Network class create a requests to api and wrap json encoders and http errors
 */
class Network {
    /*
     Define if requests print debug info on console
     */
    var debugMode = false
    /*
     initializer for jsonEncoder config to using SnakeCase converting entitie with _ to Snake
     */
    internal let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        return jsonEncoder
    }()
    /*
     initializer for jsonDecoder config to using SnakeCase converting entitie with _ to Snake
     */
    internal let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    /*
     Initialize to constant JSONError
     */
    let defaultJsonError = JSONError(msg: "Invalid Json")
    
    /*
     String token used on requests
     */
    internal var usedToken = ""
    
    /*
     Constant to Manage connection using SessionManager from Alamofire
     
     SeeAlso 'SessionManager'
     */
    internal let alamofireManager: SessionManager = {
        //Criação das configurações
        let configurarion = URLSessionConfiguration.default
        //Tempo de timeout em milesegundos
        configurarion.timeoutIntervalForRequest = 10000
        configurarion.timeoutIntervalForResource = 10000
        return SessionManager(configuration: configurarion)
    }()
    
    /*
     Wrapper HttpMethods used on App
     */
    public enum Method {
        case post
        case put
        case get
        //case delete
        case patch
        
        var value: String {
            switch self {
            case .post:
                return HTTPMethod.post.rawValue
            case .put:
                return HTTPMethod.put.rawValue
            case .get:
                return HTTPMethod.get.rawValue
            case .patch:
                return HTTPMethod.patch.rawValue
            }
        }
    }
    /*
     Request Method create all requests on aplication
     
     - Parameter url: ***String*** Api URL to request - Defined on Endpoints.swift
     - Parameter method: ***Method?*** an enum method
     - Parameter body: ***Data?*** an Data from JSONEncoder if empty request hide this info
     - Parameter useToken: ***Bool?*** flag if request use or not token Default true
     */
    internal func request(url: String, method: Method? = .get, body: Data? = nil, useToken: Bool? = false) -> DataRequest{
        var request = URLRequest(url: URL(string: url)!)
        if let _ = useToken {
            //usedToken = AuthenticationManager.token
            //request.setValue(usedToken, forHTTPHeaderField: "Authorization")
            request.setValue("397866069316452577374161031370", forHTTPHeaderField: "app-key")
            request.setValue("e45a08a09efecb93bc60fca48a24125785e079c6", forHTTPHeaderField: "app-secret")
        }
        request.httpMethod = method?.value
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let httpBody = body {
            request.httpBody = httpBody
        }
        return alamofireManager.request(request)
    }
    /*
     Return a NetworkError to completion request
     
     - Parameter statusCode: ***Int*** an statusCode from response
     - Parameter responseValue: ***String*** an response value from response
     */
    internal func error(statusCode: Int, responseValue: [[String: Any]]) -> NetworkError{
        ////noConnection = -1009
        //timeOut = -1001
        return NetworkError(msg: "Erro \(statusCode): ResultValue \n\(responseValue))", statusCode: statusCode)
    }
}
