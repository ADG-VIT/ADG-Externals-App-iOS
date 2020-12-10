//
//  managementQues.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 08/12/20.
//

import Foundation

struct managementModel: Decodable {
    let id, Description, questionImage: String
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case Description = "description"
        case questionImage
        case v = "__v"
    }
}

