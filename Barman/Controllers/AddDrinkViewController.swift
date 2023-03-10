//
//  AddDrinkViewController.swift
//  Barman
//
//  Created by raul.oropeza on 04/03/23.
//

import UIKit
import CoreData

class AddDrinkViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var directionsTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var newDrink: DrinkCoreData?
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        newDrink = DrinkCoreData(context: context)
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TableDrinkViewController
        
        newDrink?.name = nameTextField.text ?? ""
        newDrink?.ingredients = ingredientsTextField.text ?? "VACIO"
        newDrink?.directions = directionsTextField.text ?? "Vacio"
        newDrink?.img = ""
        
        
        //destination.newDrink = newDrink
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        if newDrink?.name != ""{
            perform = true
        }
        else{
             //userMessage(alertTitle: "Warning", message: "Title is required", actionTitle: "Ok", vc: self)
            //let alert = UIAlertView(title: "Warning", message: "Tittle is required", delegate: nil, cancelButtonTitle: "OK")
                
            }
        return perform
    }
    @IBAction func saveAction(_ sender: Any){
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DrinkCoreData", in: context)
        let newDrink = DrinkCoreData(entity: entity!, insertInto: context)
        newDrink.name = nameTextField.text
        newDrink.ingredients = ingredientsTextField.text
        newDrink.directions = directionsTextField.text
        newDrink.img = ""
         do{
         try context.save()
         totalObjects.append(newDrink )
         navigationController?.popViewController(animated:true)
         }catch{
             print("Context save error")
         }*/
    }
    



}
