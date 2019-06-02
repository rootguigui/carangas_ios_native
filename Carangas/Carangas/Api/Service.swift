//
//  Service.swift
//  Carangas
//
//  Created by gui on 01/06/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation

class Service {
    
    class func applyOperation(basePath: String ,car: Car, operation : RESTOperation, onComplete: @escaping (Bool) -> Void) {
        let urlBase: String = "https://carangas.herokuapp.com/"
        let session = Configuration.session
        
        let urlString = urlBase +  basePath + "/" + (car._id ?? "")
        
        guard let url = URL(string: urlString) else {
            onComplete(false)
            return
        }
        
        var requestMethod: String = ""
        
        switch operation {
        case .save:
            requestMethod = "POST"
        case .update:
            requestMethod = "PUT"
        case .delete:
            requestMethod = "DELETE"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }
}
