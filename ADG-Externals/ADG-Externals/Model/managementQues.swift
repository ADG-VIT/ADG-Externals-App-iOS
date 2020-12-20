//
//  managementQues.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 08/12/20.
//

import Foundation

struct managementModel: Decodable {
    let id, questionDescription: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case questionDescription = "description"
        case v = "__v"
    }
}

