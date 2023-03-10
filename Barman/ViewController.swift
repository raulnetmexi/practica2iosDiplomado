//
//  ViewController.swift
//  Barman
//
//  Created by raul.oropeza on 28/02/23.
//

import UIKit

class ViewController: UIViewController {
    var recivedDrink: Drink?
    var imgDrink: String = ""
    @IBOutlet weak var drinkTitle: UILabel!
    
    @IBOutlet weak var drinkTask: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var drinkIngredients: UILabel!
    @IBOutlet weak var ingredientTitle: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    lazy var urlLocal: URL? = {
        var tmp = URL(string: "")
        if let documentsURL = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first {
            //tmp = documentsURL.appendingPathComponent("drinks.json")
            tmp = documentsURL.appendingPathComponent(imgDrink)
            print(imgDrink)
        }
        return tmp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgDrink = recivedDrink!.img
        //Verificamos si el archivo esta descargado
        if FileManager.default.fileExists(atPath:urlLocal?.path ?? "") {
            print("1URL:\(urlLocal)")
            print("1img:\(imgDrink)")
                        drinkTitle.text = self.recivedDrink?.name
            DispatchQueue.main.async {
                self.drinkImage.image = UIImage(contentsOfFile: (self.urlLocal?.path())!)
            }
                        ingredientTitle.text = "Ingredients:"
                        drinkIngredients.text = self.recivedDrink?.ingredients
                        taskTitle.text = "Tasks:"
                        drinkTask.text = self.recivedDrink?.directions
                     
        }
        else {
            //file:///Users/raul.oropeza/Library/Developer/CoreSimulator/Devices/DA94B6ED-C375-40B1-8628-60B85BA75446/data/Containers/Data/Application/988CF1B3-480E-4E93-8797-F594A59279E7/Documents/"    0x0000600003c73420
            //"file:///Users/raul.oropeza/Library/Developer/CoreSimulator/Devices/DA94B6ED-C375-40B1-8628-60B85BA75446/data/Containers/Data/Application/988CF1B3-480E-4E93-8797-F594A59279E7/Documents/"    0x0000600002375380
            //saber si tenemos conexion a internet
            if InternetMonitor.instance.internetStatus {
                guard let laURL = URL(string:"http://janzelaznog.com/DDAM/iOS/drinksimages/\(recivedDrink!.img)") else {return}
                print("2img:\(imgDrink)")
                // Implementación de descarga en background con URLSession
                //1. Establecemos la configuracion para la sesión o usamos la basica
                let configuration = URLSessionConfiguration.ephemeral
                //2.Creamos la sesión de descarga, con la configuración elegida
                let session = URLSession(configuration: configuration)
                //3. Creamos el request para especificar lo que queremos obtener
                let elReq = URLRequest (url: laURL)
                //4. Creamos la tarea especifica de descarga
                let task = session.dataTask(with: elReq) { bytes, response, error in
                    // Que queremos que pase al recibir el response:
                    if error == nil {
                        guard let data = bytes else { return }
                        do {
                            try data.write(to:self.urlLocal!)
                        }
                        catch {
                            print ("Error al guardar el archivo " + String(describing: error))
                        }
                        DispatchQueue.main.async {
                            self.drinkTitle.text = self.recivedDrink?.name
                            self.drinkImage.image = UIImage(data: data)
                            self.ingredientTitle.text = "Ingredients:"
                            self.drinkIngredients.text = self.recivedDrink?.ingredients
                            self.taskTitle.text = "Tasks:"
                            self.drinkTask.text = self.recivedDrink?.directions
                            
                        }
                    }
                }
                // iniciamos la tarea
                task.resume()
            }else{
                //Si no tiene conexion a internet
                let ac = UIAlertController(title: "Es necesario tener internet", message: "Para poder descagar los datos", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default){
                    alertaction in
                }
                ac.addAction(action)
                self.present(ac, animated: true)
            }
            
            
        }
    }
}
