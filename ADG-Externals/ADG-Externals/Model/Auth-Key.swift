//
//  Auth-Key.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 07/12/20.
//

import Foundation
struct AuthKey :Decodable {
 
    let message: String
}

struct recruitment:Decodable {
    let status: Bool    //App status, to check recruitment live or not
}
