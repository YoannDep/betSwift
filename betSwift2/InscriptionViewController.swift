//
//  InscriptionViewController.swift
//  betSwift2
//
//  Created by stagiaire on 22/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView

class InscriptionViewController: UIViewController {
    
    let urlString = "http://192.168.56.101/"
    
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        print("InscriptionViewController")
        nametxt.text = "Test1@test.com"
        emailTxt.text = "Test1@test.com"
        passwordTxt.text = "0000"


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateUserBtn(_ sender: UIButton) {
        if emailTxt.text != "" && passwordTxt.text != ""  && nametxt.text != "" {
            let params: Parameters = [
                "name": nametxt.text!,
                "email": emailTxt.text!,
                "password": passwordTxt.text!            ]
            
            let token:String? = UserDefaults.standard.object(forKey: "token") as! String?
            //print(token!)
            let headers: HTTPHeaders = ["Accept": "application/json" ,
                                        "Authorization": "Bearer "+token! ]
            
            
            Alamofire.request(urlString + "api/user", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response:DataResponse<Any>) in
                if response.result.isSuccess {
                    if let result:[String:Any] = response.result.value as? [String:Any] {
                        
                        print(response.result.value )
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        CDAlertView(title: "Félicitation, votre compte a été crée  ", message: "Connecter-vous  ! ", type: .success).show()
                        
                    }
                    
                }else {
                    //self.errorLbl.text = "Indentifiants invalides"
                    print("failed")
                }
            }
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
