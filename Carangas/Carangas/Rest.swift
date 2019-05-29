//
//  Rest.swift
//  Carangas
//
//  Created by gui on 28/05/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case ResponseStatusCode(code: Int)
    case invalidJson
}

class REST {
    
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    private static let configuration: URLSessionConfiguration = {
       let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session =  URLSession(configuration: configuration) //URLSession.shared
    
    class func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    } catch {
                        print(error.localizedDescription)
                        onError(.invalidJson)
                    }

                } else {
                    onError(.ResponseStatusCode(code: response.statusCode))
                }
                
            } else {
                onError(.taskError(error: error!))
            }
            
        }
        dataTask.resume()
    }
    
}
