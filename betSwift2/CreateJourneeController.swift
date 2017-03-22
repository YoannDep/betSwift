//
//  CreateJourneeController.swift
//  betSwift2
//
//  Created by stagiaire on 22/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire

class CreateJourneeController: UIViewController {

    @IBOutlet weak var labelNameJournee: UITextField!
    @IBOutlet weak var labelNameEquipe1: UITextField!
    @IBOutlet weak var labelNameEquipe2: UITextField!
    @IBOutlet weak var btnCreateEquipe: UIButton!
    @IBOutlet weak var btnValide: UIButton!
    
    var dataTable:NSDictionary = [:]
    let urlString = "http://192.168.56.102/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createJournee(_ sender: UIButton) {
//        if labelNameJournee.text != ""{
//            let params: Parameters = [
//                "nom": labelNameJournee.text!
//            ]
//            let token:String? = UserDefaults.standard.object(forKey:"token") as! String?
//            let headers:HTTPHeaders = ["Accept": "application/json", "Authorization":"Bearer "+token!]
//            let idChamp:String? = UserDefaults.standard.object(forKey: "idChamp") as? String
//            
//            Alamofire.request(urlString + "api/championnat/"+idChamp!+"/journee", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
//                
//                if let result = response.result.value{
//                    let resultResponse:NSDictionary? = result as? NSDictionary
//                    self.dataTable = resultResponse!.value(forKey: "data") as! NSDictionary
//                    print(self.dataTable)
//                }
//                
//            }
//        }else{
//           print("failed")
//        }
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
