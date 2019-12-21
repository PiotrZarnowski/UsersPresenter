//
//  WebService.swift
//  UsersPresenter
//
//  Created by Piotr Żarnowski on 17/12/2019.
//  Copyright © 2019 Piotr Żarnowski. All rights reserved.
//

import Foundation

protocol DataTransferService {

  func getResource<W>(_ resource: Resource<W>, _ completion: @escaping ((Result<W, Error>) -> ()))
}

//protocol GitHubUserProvider {
//  func getResource(_ resource: Resource<GitHubUser>, _ completion: @escaping ((Result<GitHubUser, Error>) -> ())) -> Cancellable?
//}


struct WebService: DataTransferService {
        
     func getResource<T>(_ resource: Resource<T>, _ completion: @escaping ((Result<T, Error>) -> ())) {
        
        let task = URLSession(configuration: .default).dataTask(with: resource.url) { (data, response, error) -> Void in

            if let error = error {
                print("WebService call \(resource.url) error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return completion(.failure(NoDataError.Error))
            }
            
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == resource.exceptedStatus {
                do {
                    let resultResource = try resource.parseMethod(data)
                    completion(.success(resultResource))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(ResponseCodeError.Error(responseCode: statusCode)))
            }
        }
        task.resume()
    }
}

enum NoDataError: Error {
    case Error
}

enum ResponseCodeError: Error {
    case Error(responseCode: Int)
}

//class WebService: Requestable {
//
//     func getResource(_ resource: Resource<T>, _ completion: @escaping ((Result<T, Error>) -> ())) -> Cancellable? {
//
//        let task = URLSession(configuration: .default).dataTask(with: resource.url) { (data, response, error) -> Void in
//
//            if let error = error {
//                print("WebService call \(resource.url) error: \(error)")
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                return completion(.failure(NoDataError.Error))
//            }
//
//
//            let statusCode = (response as! HTTPURLResponse).statusCode
//            if statusCode == resource.exceptedStatus {
//                do {
//                    let resultResource = try resource.parseMethod(data)
//                    completion(.success(resultResource))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            } else {
//                completion(.failure(ResponseCodeError.Error(responseCode: statusCode)))
//            }
//        }
//        task.resume()
//        return task
//    }
//}

