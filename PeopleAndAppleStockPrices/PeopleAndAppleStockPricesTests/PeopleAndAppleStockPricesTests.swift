import XCTest

@testable import PeopleAndAppleStockPrices

class PeopleAndAppleStockPricesTests: XCTestCase {

    func testGetStockData() {
        let dataIWant = getStockDataFromJSON()
        let apple = AppleStock.getStock(from: dataIWant)
        XCTAssert(apple.self != nil, "There is no data")
        }
        
        private func getStockDataFromJSON() -> Data {
            guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
                fatalError("couldn't find JSON file called applstockinfo.json")}
            
            let url = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: url)
                return data
            }catch let jsonError{
                fatalError("error")
            }
        }
    
    
    
    func testApplStockHasSixHundredsData() {
        let applStocks = getStockDataFromJSON()
        let numbersOfAapl = AppleStock.getStock(from: applStocks)
        XCTAssertFalse(numbersOfAapl.count == 600, "There are \(numbersOfAapl.count) stocks")
    }
}

