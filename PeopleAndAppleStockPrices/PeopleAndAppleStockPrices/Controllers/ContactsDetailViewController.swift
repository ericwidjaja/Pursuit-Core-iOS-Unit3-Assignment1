//
//  ContactsDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Eric Widjaja on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.

import UIKit

class ContactsDetailViewController: UIViewController {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactLocationLabel: UILabel!
    
    var person: ContactInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL.init(string: person.picture.large) {
            do {
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    contactImage.image = image
                }
            } catch {
                contactImage.image = UIImage.init(named: "profileImage")
                print("image error is: \(error)")
            }
        }
        contactNameLabel.text = person.name.first.capitalized + " " + person.name.last.capitalized
        contactEmailLabel.text = person.email
        contactLocationLabel.text = person.location.state.capitalized
    }
    
    
}
