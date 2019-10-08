//
//  AppleStockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Eric Widjaja on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class AppleStockViewController: UIViewController {

//    MARK: - Properties
    var twoYearStock: [AppleStock] = [] {
        didSet {
            appleStockTableView.reloadData()
        }
    }
    
    var monthSections = [String]() //This will be the header title. "09/2019", " 08/2019", etc
    var groupedStocks = [String: [AppleStock]]()
    var organizedTwoYearStock = [AppleStock]()
    
//  MARK: - IBOutlet
    @IBOutlet weak var appleStockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        appleStockTableView.dataSource = self
        appleStockTableView.delegate = self
        
    }
    
    
    private func loadData() {
    if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
        let myURL = URL.init(fileURLWithPath: path)
        if let data = try? Data.init(contentsOf: myURL) {
            do {
                self.twoYearStock = try JSONDecoder().decode([AppleStock].self, from: data)
                groupedStocks = AppleStock.buildMyGroupedStocksForTheHeaders(stockArrayToBuildFrom: twoYearStock)
                //We initialized the variable groupedStocks but it's empty. We need to put stuff in it so that it has actual values.
                //Our function in the model needs a stock array to build the dictionary from.
                //We will pass it the actual twoYearStock array that has all the data inside of it.
                
                monthSections = Array(groupedStocks.keys) //This goes through the dictionary array, picks out the keys (which are the dates) and makes a new array of just those keys/dates. This will be used for the section headers.
                
                monthSections = monthSections.sorted()
                
            } catch {
                print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AppleStockDetailViewController, let indexPath = appleStockTableView.indexPathForSelectedRow else { return }
        let stockToDetail = organizedTwoYearStock[indexPath.row]
        destination.sortedStockInDetail = stockToDetail
    }
}


extension AppleStockViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = monthSections[section]
        guard let stocks = groupedStocks[sectionKey] else { fatalError() }
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appleStockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        let dateSectionKey = monthSections[indexPath.section]
        //Specific key from the monthSections array based on that section number
        
        guard let organizedTwoYearStock = groupedStocks[dateSectionKey] else {
            fatalError()
        }
        self.organizedTwoYearStock = organizedTwoYearStock
        //I organized my stock array here, but the segue is using the original unorganized twoYearStock array, so we are making a global variable of the same name and giving it the value of the organizedTwoYearStock we made here.
        //This will be used for the segue.
        
        let stockToDetail = organizedTwoYearStock[indexPath.row]
        //Populates the tableView with the now organized AppleStock array, called organizedTwoYearStock
        
    
        cell.textLabel?.text = stockToDetail.date
        cell.detailTextLabel?.text = "$" + String(format: "%.2f", stockToDetail.open)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let specificSection = monthSections[section]
        //Gets a specific section header based on the monthsSectionArray at the section index.
        //Ex: Say my monthsSection has [09/2018, 11/2018, 12/2018], section 3 (what I'm using to subscript) would give me a specificSection of 12/2018.
        
        guard let stocks = groupedStocks[specificSection] else {
            fatalError()
        }
        let monthlyAverage = String(format: "%.2f", AppleStock.getAveragePriceForMonth(stockArr: stocks))
        
        return "\(specificSection),                     Avg: $ \(monthlyAverage)"
    }
}

extension AppleStockViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return monthSections.count
        //ex: If there's 7 dates in the monthSections array, then we have 7 sections.
    }
}

