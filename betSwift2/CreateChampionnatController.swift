//
//  CreateChampionnatController.swift
//  betSwift2
//
//  Created by stagiaire on 22/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire

class CreateChampionnatController: UIViewController {

    @IBOutlet weak var labelNameChamp: UITextField!
    @IBOutlet weak var btnValider: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var dataTable:NSDictionary = [:]
    let urlString = "http://192.168.56.101/"
    
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
                    if let result = response.result.value{
                        let resultResponse:NSDictionary? = result as? NSDictionary
                        self.dataTable = resultResponse!.value(forKey: "data") as! NSDictionary
                        UserDefaults.standard.set(self.dataTable.value(forKey: "id"), forKey: "idChamp")
                        
                    }
                    
                }
            }
            
        }else{
            self.errorLabel.text = "le nom n'a pas été rentré"
        }

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
