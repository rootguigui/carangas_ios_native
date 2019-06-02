//
//  CarError.swift
//  Carangas
//
//  Created by gui on 01/06/19.
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
