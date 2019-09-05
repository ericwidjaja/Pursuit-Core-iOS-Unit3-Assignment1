//
//  AppleStockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Eric Widjaja on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class AppleStockDetailViewController: UIViewController {
    
    @IBOutlet weak var aaplDateLabel: UILabel!
    
    @IBOutlet weak var aaplImage: UIImageView!
    
    @IBOutlet weak var aaplOpenLabel: UILabel!
    
    
    @IBOutlet weak var aaplCloseLabel: UILabel!
    
    
    
    
    var sortedStockInDetail: AppleStock!

    override func viewDidLoad() {
        super.viewDidLoad()
        aaplDateLabel.text = sortedStockInDetail.date
        aaplOpenLabel.text = "Open: $" + String(format: "%.2f", sortedStockInDetail.open)
        aaplCloseLabel.text = "Close: $" + String(format: "%.2f", sortedStockInDetail.close)
        if sortedStockInDetail.close - sortedStockInDetail.open >= 0 {
            aaplImage.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .green
        } else {
            aaplImage.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .red
        }
    }
}
