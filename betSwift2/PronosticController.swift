//
//  PronosticController.swift
//  betSwift2
//
//  Created by stagiaire on 23/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire

class PronosticController: UIViewController {

    @IBOutlet weak var btnValider: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let urlString = "http://192.168.56.101/"
    var pronostics = [[String:Any]]()
    var pronostic = [String:Any]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        let token:String? = UserDefaults.standard.object(forKey: "token") as! String?
        if token != nil {
            let headers: HTTPHeaders = ["Accept":"application/json", "Authorization": "Bearer "+token!]
            let idJournee:Int = UserDefaults.standard.integer(forKey: "idJournee")

            Alamofire.request(urlString + "api/journee/\(idJournee)/match", headers: headers).responseJSON { response in
                if let jsonDict = response.result.value as? [String:Any],
                    let dataArray = jsonDict["data"] as? [[String:Any]] {
                    
                    self.pronostics = dataArray
                    for data in dataArray 	{
                        print("data \(data["nom"]!)")
                    }
                    print(self.pronostics.count)
                    self.tableView.reloadData()
                }
            }
        }
        else{
            print("else")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension PronosticController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pronostics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("ListJournee \(self.pronostics.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pronostic = self.pronostics[indexPath.row]
        cell.textLabel!.text = pronostic["nom"] as! String?
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let pronostic:[String:Any] = self.pronostics[indexPath.row]
        print(pronostic["id"]!)
        UserDefaults.standard.set(pronostic["id"]!, forKey: "idJournee")
        self.pronostic = self.pronostics[indexPath.row]
        
        
        performSegue(withIdentifier: "showDashboardJournee", sender: self)
    }
    
    
    
}
