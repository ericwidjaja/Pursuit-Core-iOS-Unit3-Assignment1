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
    
    func getAppleStockDateInDateFormat() -> Date {
        return date.toDate(dateFormatIWantMyDateIn: "yyyy-MM-dd")!
    }
    
    static func trimDate(date: String) -> String {
        return String(date.dropLast(3)) //removes the -dd from the date format
    }
    
    
    static func stockFilter (stockArr: [AppleStock]) -> [String : [AppleStock]] {
        var dictionary = [String:[AppleStock]]()
        //First, we make a dictionary. The dictionary will have the key as the date and the value will be an array of stocks that match that date. For example, the key can be '2017-09' and the value will be all the stocks for that month as an array.
        
        for specificStock in stockArr {
            let dateKey = AppleStock.trimDate(date: specificStock.date)
            //This removes the -dd from the date format for each of the AppleStock instances.
            
            if var stocks = dictionary[dateKey] { //As I'm iterating through stockArr, if I find a specific stock that match the dateKey...
                stocks.append(specificStock) //then I want to append it to that stock array.
                
                dictionary[dateKey] = stocks
            } else {
                dictionary[dateKey] = [specificStock]
            }
        }
        
        return dictionary
    }
    
    static func getAveragePriceForMonth(stockArr: [AppleStock]) -> Double { //I want to give this function an array of AppleStock so that it can go through them, find the opening price for each AppleStock, and give me the average as a double.
        
        var stockOpeningPriceSum = 0.0
        
        for specificStock in stockArr {
            stockOpeningPriceSum = specificStock.open + stockOpeningPriceSum //So if my stock 1 has an open of 3, stock 2 has an open of 4, stock 3 has an open of 5, my sum is 12.
        }
        
        let average = stockOpeningPriceSum / Double(stockArr.count) //Types must match. Since the openingpricesum is a double, we want our stockArr.count to be a double as well.
        
        return average
    }
    
   static func sortMyStocksByMonth(stockArrayToSort: [AppleStock] ) -> [AppleStock] {
        return stockArrayToSort.sorted {$0.getAppleStockDateInDateFormat() < $1.getAppleStockDateInDateFormat()}
        //Goes through every stock in the stockArray, and checks if the date is 'bigger' than the next date.
        //Example:
        //In my stock array ( [ Stock 1, Stock 2, Stock 3] )
        //Stock 1 has a date of 08/2019, Stock 2 has a date of 09/2019. Stock 3 has a date of 07/2019
        //09 is bigger than 08, so Stock 1 is kept on the left side. Stock 2 stays where it is, for now.
        //Now, it will check, is the date of Stock 2 smaller than the date of Stock 3? Is 09 < 07?
        //No. So now, Stock 3 will be moved to the left of Stock 2. Stock 2 is now the last element in the array.
        //The returned & sorted array now looks like [Stock 1, Stock 3, Stock 2]
    }
    
    
    static func buildMyGroupedStocksForTheHeaders(stockArrayToBuildFrom: [AppleStock]) -> [String: [AppleStock]] {
        let sortedStocks = sortMyStocksByMonth(stockArrayToSort: stockArrayToBuildFrom)
        //Here, we are making an array of stocks that are now sorted. We will use this sorted stock array to build our headers so that the headers aren't all out of date.
        //Example: We don't want the first section header to be 09/2019 and then the second header is 07/2016, because that doesn't make sense intuitively. We want them to be in order of the date.
        
        let groupedStocks = AppleStock.stockFilter(stockArr: sortedStocks)
        //From our sorted stock array, we are now going through the stocks inside of it and using our stockFilter function to make the dictionary that has the key as the date and stocks associated with the key as an array of AppleStock ([AppleStock])
        
        return groupedStocks //The type of this property is [String: [AppleStock]]
        
        //Now, we can use this to set up our viewcontroller headers.
    }
}






//TO DO for Sections:

/* Figure out filtering the model by the date
 maybe use matrix as arrays of array,
 
 create a func to make the avg monthly
 then, create
 */
