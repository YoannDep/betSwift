//
//  ViewController.swift
//  betSwift2
//
//  Created by stagiaire on 21/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView

class LoginController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    var loginSuccess:BooleanLiteralType = false
    
    let urlString = "http://192.168.56.101/"

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.text = "test@test.com"
        passwordTxt.text = ""
        
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
    
    
    @IBAction func loginTouched(_ sender: UIButton) {
        print("Login Touched...")
    }
    
    func showLogin(){
        self.logoutBtn.isHidden = true
        self.emailTxt.isHidden = false
        self.passwordTxt.isHidden = false
        self.subscribeBtn.isHidden = false
        self.loginBtn.setTitle("Valider",for: .normal)
        
        emailTxt.text! = "test@test.com"
        passwordTxt.text! = ""
    }
    
    func disableLogin(){
        self.logoutBtn.isHidden = false
        self.loginSuccess = true
        self.emailTxt.isHidden = true
        self.passwordTxt.isHidden = true
        self.subscribeBtn.isHidden = true
        self.loginBtn.setTitle("Championnats",for: .normal)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        if let ident = identifier {
            if ident == "mainSegue" {
                
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
                                    
                                    CDAlertView(title: "Bienvenue sur BetSwift", message: "Avec BetSwift, pariez entre vous sans limite !", type: .success).show()
                                    
                                    self.performSegue(withIdentifier: "mainSegue", sender: self)
                                    
                                }
                                
                            }else {
                                
                                CDAlertView(title: "Indentifiants invalides", message: "Votre identifiant et votre mot de passe ne correspondent pas", type: .error).show()
                            }
                        }
                        
                    }else{
                        CDAlertView(title: "Indentifiants incomplets", message: "Veuillez saisir votre identifiant ainsi que votre mot de passe", type: .error).show()
                    }
                    
                }
                
            }
            if ident == "showInscription" {
                self.loginSuccess = true
            }
        }
        
        return self.loginSuccess
    }

    @IBAction func logoutTouched(_ sender: UIButton) {
        print("Deconnexion....")
        UserDefaults.standard.setValue(nil, forKey: "token")
        self.showLogin()
        self.loginSuccess = false
        CDAlertView(title: "A bientot", message: "BetSwift, c'est avant tout la joie d'un pari bien fait", type: .success).show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

