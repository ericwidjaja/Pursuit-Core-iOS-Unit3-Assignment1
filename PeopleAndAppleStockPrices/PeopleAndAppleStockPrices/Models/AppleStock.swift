//
//  AppleStock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Eric Widjaja on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppleStock: Codable {
    let date: String
    let open: Double
    let close: Double
    
    static func getStock(from data: Data) -> [AppleStock] {
        do {
            let stock = try JSONDecoder().decode([AppleStock].self, from: data)
            return stock
        } catch let decodeError {
            fatalError("could not decode info \(decodeError)")
            
        }
        
    }
    
}


//TO DO for Sections:

/* Figure out filtering the model by the date
 maybe use matrix as arrays of array,
 
 create a func to make the avg monthly
 then, create
 */
