//
//  Extensions.swift
//  PeopleAndAppleStockPrices
//
//  Created by Eric Widjaja on 10/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
extension String {

    func toDate(dateFormatIWantMyDateIn: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatIWantMyDateIn
        let date = dateFormatter.date(from: self)
        return date
    }
}
