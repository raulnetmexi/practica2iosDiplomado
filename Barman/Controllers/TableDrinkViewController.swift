//
//  TableDrinkViewController.swift
//  Barman
//
//  Created by raul.oropeza on 28/02/23.
//

import UIKit

class TableDrinkViewController: UITableViewController {
    //TableView
    var objects =  Drinks()
    var drink: Drink?
    //COredata
    //let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    //var dataManager : DrinkCoreDataManager?

    
    lazy var urlLocal: URL? = {
        var tmp = URL(string: "")
        if let documentsURL = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first {
            tmp = documentsURL.appendingPathComponent("drinks.json")
        }
        return tmp
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       // dataManager = DrinkCoreDataManager(context: context)
        //dataManager!.fetch()
    }
    

        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if InternetMonitor.instance.internetStatus{
            
        }
        //Consultar el doc y searlizar el JSON
        guard let laURL = Bundle.main.url(forResource: "drinks", withExtension: "json") else { return }
       // guard let laURL = URL(string: "http://janzelaznog.com/DDAM/iOS/drinks.json") else { return }
        //let request = URLRequest(url: laURL)
        do {
            let bytes = try Data(contentsOf: laURL)
            let drinks = try? JSONDecoder().decode(Drinks.self, from: bytes)
            objects = drinks!
            print("0Table:\(objects)")
            self.tableView.reloadData()
        } catch {
            print("Error al descargar el JSON " + String(describing: error))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
        //return objects.count + (dataManager?.countDrink())!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //var objectsFinal = objects + (dataManager?.getDrinks() as! Array<Drink>)
        drink = objects[indexPath.row]
        //drink = objectsFinal[indexPath.row]
        cell.textLabel?.text = drink?.name
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        drink = objects[indexPath.row]
        performSegue(withIdentifier: "show", sender: self.self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show"{
            let destination = segue.destination as! ViewController
            destination.recivedDrink = drink
        }else{
            if segue.identifier == "addDrink"{
                let destination = segue.destination as! AddDrinkViewController
            }
        }
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
