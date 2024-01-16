//
//  Petitions.swift
//  Project7
//
//  Created by Илья Сидоров  on 08.12.2023.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}
