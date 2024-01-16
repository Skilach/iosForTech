//
//  Person.swift
//  Project10
//
//  Created by Илья Сидоров  on 12.01.2024.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
