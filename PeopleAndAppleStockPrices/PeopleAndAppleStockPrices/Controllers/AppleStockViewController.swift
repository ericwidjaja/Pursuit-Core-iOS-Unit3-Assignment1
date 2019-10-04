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
    
    var month = [String]()
    var stocks = [[AppleStock]]()
    

//  MARK: - IBOutlet
    @IBOutlet weak var appleStockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        appleStockTableView.dataSource = self
//        appleStockTableView.delegate = self
        
    }
    func loadData() {
    if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
        let myURL = URL.init(fileURLWithPath: path)
        if let data = try? Data.init(contentsOf: myURL) {
            do {
                self.twoYearStock = try JSONDecoder().decode([AppleStock].self, from: data)
            } catch {
                print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AppleStockDetailViewController, let indexPath = appleStockTableView.indexPathForSelectedRow else { return }
        let stockToDetail = twoYearStock[indexPath.row]
        destination.sortedStockInDetail = stockToDetail
    }
}


extension AppleStockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoYearStock.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appleStockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stockToDetail = twoYearStock[indexPath.row]
        cell.textLabel?.text = stockToDetail.date
        cell.detailTextLabel?.text = "$" + String(format: "%.2f", stockToDetail.open)
        return cell
    }
}

extension AppleStockViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoYearStock.count
    }
}

