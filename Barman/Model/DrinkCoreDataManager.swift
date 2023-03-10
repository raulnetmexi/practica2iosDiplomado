//
//  DrinkCoreDataManager.swift
//  Barman
//
//  Created by raul.oropeza on 04/03/23.
//

import Foundation
import CoreData
class DrinkCoreDataManager{
    private  var drinks : [DrinkCoreData] = []
    private var context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    func fetch() {
        do{
            self.drinks = try self.context.fetch(DrinkCoreData.fetchRequest())
        }
        catch{
            print("Error:", error)
        }
    }
    func getDrink(at index : Int) -> DrinkCoreData {
        return drinks[index]
    }
    func getDrinks() -> [DrinkCoreData] {
        return drinks
    }
    
    func countDrink() -> Int {
        return drinks.count
    }
    
    func pushDrink(newdrink : DrinkCoreData){
        drinks.append(newdrink)
    }
    func deleteTask(at index : Int){
        drinks[index].setValue(nil, forKey:"name")
    }
}
