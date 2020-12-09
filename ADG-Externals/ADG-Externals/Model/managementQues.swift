//
//  managementQues.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 08/12/20.
//

import Foundation

struct submission:Decodable{
    let message:String
}
struct managementQuesArr:Decodable{
    var ques:[managementQues]
}
struct managementQues:Decodable{
    var id:String
    var description:String
    var questionImage:String?
    var v:Int?
    
     enum CodingKeys: String, CodingKey {

         case id = "_id"
         case description
         case questionImage


     }
    
    
    
   
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        qid = try container.decode(String.self, forKey: .qid)
//        question = try container.decode(String.self, forKey: .question)
//        quesImage = try? container.decode(String?.self, forKey: .quesImage)
//
//    }
   
}
