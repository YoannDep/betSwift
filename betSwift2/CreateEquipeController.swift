//
//  CreateEquipeController.swift
//  betSwift2
//
//  Created by stagiaire on 23/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire

class CreateEquipeController: UIViewController {

    @IBOutlet weak var labelEquipe1: UITextField!
    @IBOutlet weak var labelEquipe2: UITextField!
    @IBOutlet weak var btnValideEquipe: UIButton!
    @IBOutlet weak var btnAddEquipe: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dataTable:NSDictionary = [:]
    var tableEquipe = [Any]()
    let urlString = "http://192.168.56.101/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEquipe(_ sender: UIButton) {
        if labelEquipe1.text != "" && labelEquipe2.text != ""{
            
            let params: Parameters = [
                "entite_id_1": labelEquipe1.text!,
                "entite_id_2": labelEquipe2.text!
            ]
            
            let token:String? = UserDefaults.standard.object(forKey:"token") as! String?
            let headers:HTTPHeaders = ["Accept": "application/json", "Authorization":"Bearer "+token!]
            let idJournee:Int = UserDefaults.standard.integer(forKey: "idJournee")
            print(idJournee)
            Alamofire.request(urlString + "api/journee/\(idJournee)/match", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                print("toto")
            }
            
            let equipeConcat:String = labelEquipe1.text! + " - " + labelEquipe2.text!
            self.tableEquipe.insert(equipeConcat, at: 0)
            labelEquipe1.text = ""
            labelEquipe2.text = ""
            self.tableView.reloadData()
            

        }
    }

}

extension CreateEquipeController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableEquipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("count \(tableEquipe.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let equipes = self.tableEquipe[indexPath.row]
        
        print(equipes)
        cell.textLabel!.text = equipes as! String
        
        return cell
    }
    
    
    
    
}
