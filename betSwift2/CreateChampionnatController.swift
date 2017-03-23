//
//  CreateChampionnatController.swift
//  betSwift2
//
//  Created by stagiaire on 22/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView

class CreateChampionnatController: UIViewController {

    @IBOutlet weak var labelNameChamp: UITextField!
    @IBOutlet weak var btnValider: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var dataTable:NSDictionary = [:]
    let urlString = "http://192.168.56.101/"
    var championnat = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createChampionnat(_ sender: UIButton) {
        if labelNameChamp.text != ""{
            let params: Parameters = [
                "nom": labelNameChamp.text!
            ]
            let token:String? = UserDefaults.standard.object(forKey:"token") as! String?
            let headers:HTTPHeaders = ["Accept": "application/json", "Authorization":"Bearer "+token!]
            if token != nil {
                Alamofire.request(urlString + "api/championnat", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response    in
                    print(response.result.value)
                    if let result = response.result.value{
                        let resultResponse:NSDictionary? = result as? NSDictionary
                        self.dataTable = resultResponse!.value(forKey: "data") as! NSDictionary
                        UserDefaults.standard.set(self.dataTable.value(forKey: "id"), forKey: "idChamp")
                        self.championnat =  resultResponse!.value(forKey: "data") as! [String:Any]
                        print( resultResponse!.value(forKey: "data") as! [String:Any])
                        
                        CDAlertView(title: "Félicitation ", message: "Le championnat a été crée  ! ", type: .success).show()
                        
                        self.performSegue(withIdentifier: "showChampionnatCreate", sender: self)
                    }
                    
                }
            }
            
        }else{
            CDAlertView(title: "Echec", message: "Le nom n'a pas été rentré ", type: .error).show()

            self.errorLabel.text = "Le nom n'a pas été rentré"
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier == "showChampionnatCreate" {
           
            let dashboardChampionnatController = (segue.destination as! UINavigationController).topViewController as! DashboardChampionnatController
            print ("championnat \(championnat)")
           dashboardChampionnatController.championnat = self.championnat
        }
    }

 
}
