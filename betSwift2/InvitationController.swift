//
//  InvitationController.swift
//  betSwift2
//
//  Created by stagiaire on 23/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView
class InvitationController: UIViewController {
    
    var championnat = [String:Any]()
    
    let urlString = "http://192.168.56.101/"
    
    @IBOutlet weak var nameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("InvitationController  \(championnat)")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func InvitePlayerBtn(_ sender: Any) {
        print(nameTxt.text!)
        
        if nameTxt.text != ""{
            let params: Parameters = [
                "name": nameTxt.text!
            ]
            print(params)
            let token:String? = UserDefaults.standard.object(forKey:"token") as! String?
            let headers:HTTPHeaders = ["Accept": "application/json", "Authorization":"Bearer "+token!]
            if token != nil {
                

                Alamofire.request(urlString + "api/championnat/\(championnat["id"]!)/invit", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                    debugPrint(response)
                    print("Success: \(response.result.isSuccess)")
                    print("Response String: \(response.result.value)")
                    
                    if let jsonDict = response.result.value as? [String:Any],
                        let error = jsonDict["error"] as? Bool{
                        print(error)
                        if error == true {
                            
                            CDAlertView(title: "Echec ", message: "Nom inconnu  ! ", type: .error).show()
                        }else {
                            
                            CDAlertView(title: "Félicitation ", message: "Invitation envoyée ! ", type: .success).show()
                        }
                    }
                }
                
                
            }
            
        }else{
            CDAlertView(title: "Echec", message: "Le nom n'a pas été rentré ", type: .error).show()
            
        }
        

    }
    

    
}
