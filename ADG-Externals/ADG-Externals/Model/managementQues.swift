//
//  managementQues.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 08/12/20.
//

import Foundation
struct managementQues:Decodable{
    var qid:String
    var question:String
    var quesImage:String?
    
     enum CodingKeys: String, CodingKey {
         
         case qid
         case question
         case quesImage = "url"
       
         
     }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        qid = try container.decode(String.self, forKey: .qid)
        question = try container.decode(String.self, forKey: .question)
        quesImage = try? container.decode(String?.self, forKey: .quesImage)
        
    }
   
}
