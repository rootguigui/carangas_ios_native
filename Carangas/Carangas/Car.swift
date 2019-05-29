//
//  Car.swift
//  Carangas
//
//  Created by gui on 28/05/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation

class Car: Codable {
    var _id: String
    var brand: String
    var gasType: Int
    var name: String
    var price: Double
    
    var gas: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Álcool"
        default:
            return "Gasolina"
        }
    }
}
