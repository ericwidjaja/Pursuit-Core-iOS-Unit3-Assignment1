//
//  RandomUKUsers.swift
//  PeopleAndAppleStockPrices
//
//  Created by Eric Widjaja on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
//MARK-Create Structs from json file.
struct RandomUKUsers: Codable {
    let results: [ContactInfo]
}

struct ContactInfo: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let picture: PictureWrapper
    let email: String
}

struct NameWrapper: Codable {
    let title: String
    let first: String
    let last: String
}

struct LocationWrapper: Codable {
    let state: String
}

struct PictureWrapper:Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
