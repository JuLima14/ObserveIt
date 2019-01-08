//
//  TestObject.swift
//  ObserveIt
//
//  Created by JULIAN LIMA on 28/12/18.
//  Copyright © 2018 JULIAN LIMA. All rights reserved.
//

import ObserveIt

enum ExampleEnum: String {
    case property = "property"
}

class Example: Observable {
    @objc dynamic var property: String = "Hello, World!"
}
