//
//  UserProfile.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 09/12/20.
//

import Foundation

struct UserProfile:Decodable{
    
    let id:String
    let name:String
    let email:String
    let regno:String
    let yearofstudy:Int
    enum CodingKeys: String, CodingKey {

        case id
        case name
        case email
        case userDetails
        case regno
        case yearofstudy

    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .userDetails)
        self.name = try snippetContainer.decode(String.self,forKey: .name)
        self.email = try snippetContainer.decode(String.self,forKey: .email)
        self.id = try snippetContainer.decode(String.self, forKey: .id)
        self.regno = try snippetContainer.decode(String.self, forKey: .regno)
        self.yearofstudy = try snippetContainer.decode(Int.self, forKey: .yearofstudy)
    }
    
}
