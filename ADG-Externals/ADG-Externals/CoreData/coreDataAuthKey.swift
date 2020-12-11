//
//  coreDataAuthKey.swift
//  ADG-Externals
//
//  Created by Gokul Nair on 11/12/20.
//

import Foundation
import UIKit
import CoreData

class coreData {
    
    //static var token:String = ""
    
    static func saveTokenInCore(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(LogInViewController.Token, forKey: "token")
        
        do{
            try context.save()
            print("save")
        }catch{
            print("failed to save in CoreData")
        }
    }
    
    static func fetchTokenFromCore() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                LogInViewController.Token = data.value(forKey: "token") as! String
            }
        }catch{
            print("failed to fetch in CoreData")
        }
    }
    
    static func deleteAllData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
    request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for usrObj in result as! [NSManagedObject] {
                context.delete(usrObj)
            }
           try context.save() //don't forget
            LogInViewController.Token = ""
            print(LogInViewController.Token)
            }
        catch let error as NSError {
            print("delete fail--",error)
          }
   }
}
