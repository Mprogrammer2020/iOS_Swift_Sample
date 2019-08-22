//
//  Data.swift
//  SearchDemo
//
//  Created by netset on 22/08/19.
//  Copyright © 2019 NetSet. All rights reserved.
//

import Foundation

struct Data {
    var name: String!
    var age: String!
    var id: String!
    
    init(attributes: [String: String]) {
        self.name = attributes["name"]
        self.age = attributes["age"]
        self.id = attributes["id"]
    }
}
