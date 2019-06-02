//
//  Rest.swift
//  Carangas
//
//  Created by gui on 28/05/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation

class REST {
    
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    class func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        let session = Configuration.session
        
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
    
    class func save(car: Car, onComplete: @escaping (Bool) -> Void) {
        Service.applyOperation(basePath: "cars", car: car, operation: RESTOperation.save, onComplete: onComplete)
    }
    
    class func update(car: Car, onComplete: @escaping (Bool) -> Void) {
        Service.applyOperation(basePath: "cars", car: car, operation: RESTOperation.update, onComplete: onComplete)
    }
    
    class func delete(car: Car, onComplete: @escaping (Bool) -> Void) {
        Service.applyOperation(basePath: "cars", car: car, operation: RESTOperation.delete, onComplete: onComplete)
    }
}
