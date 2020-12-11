//
//  TechQuizModel.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 10/12/20.
//

import Foundation

struct jsonModel: Decodable{

    let id:String
    let questionDescription:String
    let yearofstudy:Int
    let options: Options

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case questionDescription
        case yearofstudy
        case options

    }
}
struct Options: Decodable {
    let a, b, c, d: String
}
