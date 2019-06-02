//
//  Brands.swift
//  Carangas
//
//  Created by gui on 01/06/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation


class FIPE {
    
//    https://fipeapi.appspot.com/api/1/carros/marcas.json
    
    class func loadBrands(basePath: String, onComplete: @escaping ([Brands]?) -> Void) {
        let session = Configuration.session
        
        guard let url = URL(string: basePath) else {
            onComplete(nil)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let brands = try JSONDecoder().decode([Brands].self, from: data)
                        onComplete(brands)
                    } catch {
                        print(error.localizedDescription)
                        onComplete(nil)
                    }
                } else {
                    print("Alguma coisa de errado não está certo")
                    onComplete(nil)
                }
            } else {
                onComplete(nil)
            }
        }
        dataTask.resume()
    }
}
