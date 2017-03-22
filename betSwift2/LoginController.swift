//
//  ViewController.swift
//  betSwift2
//
//  Created by stagiaire on 21/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    let urlString = "http://192.168.56.101/"

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.text = "test@test.com"
        passwordTxt.text = "0000"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

          }
    
	
    @IBAction func login(_ sender: UIButton) {
        print("email " + emailTxt.text!)
        print("password " + passwordTxt.text!)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier == "mainSegue" {
            if emailTxt.text != "" && passwordTxt.text != ""  {
                let params: Parameters = [
                    "grant_type": "password",
                    "client_id": "1",
                    "client_secret": "ZXdMNAizgOVs27EOqTil3lJGG9z4TIwDy2GdfGxR",
                    "username": emailTxt.text!,
                    "password": passwordTxt.text!            ]
                
                let headers: HTTPHeaders = ["Accept": "application/json"]
                
                
                Alamofire.request(urlString + "oauth/token", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response:DataResponse<Any>) in
                    if response.result.isSuccess {
                        if let result:[String:Any] = response.result.value as? [String:Any] {
                            let tokenResult = result["access_token"] as? String
                            print("token  : " + tokenResult!)
                            UserDefaults.standard.set(tokenResult, forKey:"token")
                           
                            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            
                           let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                        //     self.present(viewController, animated: true, completion: nil)
                            
                            viewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                            viewController.navigationItem.leftItemsSupplementBackButton = true
                            */
 
                        }
                        
                    }else {
                        self.errorLbl.text = "Indentifiants invalides"
                    }
                }
                
            }else{
                errorLbl.text = "Veuillez saisir vos identifiants"
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

