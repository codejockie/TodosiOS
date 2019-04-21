//
//  Category.swift
//  Todos
//
//  Created by John C. Kennedy on 2019/04/21.
//  Copyright © 2019 John C. Kennedy. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
