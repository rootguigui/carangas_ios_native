//
//  Configuration.swift
//  Carangas
//
//  Created by gui on 01/06/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation

class Configuration {
    
    public static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    public static let session =  URLSession(configuration: configuration) //URLSession.shared
}


