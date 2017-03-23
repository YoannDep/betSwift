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
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    var loginSuccess:BooleanLiteralType = false
    
    let urlString = "http://192.168.56.101/"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loginSuccess = false

        if let name = UserDefaults.standard.string(forKey: "token") {
            self.disableLogin()
            print(name)
        } else {
            self.showLogin()
        }
        
    }
    
    func showLogin(){
        self.logoutBtn.isHidden = true
        self.emailTxt.isHidden = false
        self.emailTxt.isHidden = false
        self.passwordTxt.isHidden = false
        self.subscribeBtn.isHidden = false
        self.loginBtn.setTitle("CONNEXION",for: .normal)
        self.errorLbl.text = "Bienvenue sur BetSwift"
        emailTxt.text! = "test@test.com"
        passwordTxt.text! = ""
    }
    
    func disableLogin(){
        self.logoutBtn.isHidden = false
        self.loginSuccess = true
        self.emailTxt.isHidden = true
        self.passwordTxt.isHidden = true
        self.subscribeBtn.isHidden = true
        self.loginBtn.setTitle("ENTRER",for: .normal)
        self.errorLbl.text = "Bienvenue sur BetSwift"
    }

  
    @IBAction func doLogin(_ sender: UIButton) {
        print("doLogin....")
    }
    
    @IBAction func subscribeTouched(_ sender: UIButton) {
        print("subscribeTouched....")
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        print("shouldPerformSegue")
        if let ident = identifier {
            if ident == "login" {
                
                print("Fonction ShouldPerform début...")
                
                if self.loginSuccess == false {
                    
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
                                    
                                    self.loginSuccess = true
                                    
                                    UserDefaults.standard.set(tokenResult, forKey:"token")
                                    
                                    self.performSegue(withIdentifier: "login", sender: self)
                                    
                                }
                                
                            }else {
                                self.errorLbl.text = "Indentifiants invalides"
                                
                            }
                        }
                        
                    }else{
                        self.errorLbl.text = "Veuillez saisir vos identifiants"
                    }
                    
                }
                
            }
            if ident == "subscribe" {
                print("subscribe...shouldPerformSegue...")
                self.loginSuccess = true
            }
        }
        
        return self.loginSuccess
    }
    
    
    @IBAction func logoutTouched(_ sender: UIButton) {
        UserDefaults.standard.setValue(nil, forKey: "token")
        self.showLogin()
        self.loginSuccess = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

