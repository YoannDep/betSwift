//
//  ListJourneeController.swift
//  betSwift2
//
//  Created by stagiaire on 23/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire

class ListJourneeController: UIViewController {
    
    let urlString = "http://192.168.56.101/"
    

    @IBOutlet weak var tableView: UITableView!
    var journees = [[String:Any]]()
    var journee = [String:Any]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        let token:String? = UserDefaults.standard.object(forKey: "token") as! String?
        if token != nil {
            print("Token ListJournee View")
            let headers: HTTPHeaders = ["Accept":"application/json", "Authorization": "Bearer "+token!]
            let idChamp:Int = UserDefaults.standard.integer(forKey: "idChamp")
            print("idChamp journee \(idChamp)")
            Alamofire.request(urlString + "api/championnat/\(idChamp)/journee", headers: headers).responseJSON { response in
                if let jsonDict = response.result.value as? [String:Any],
                    let dataArray = jsonDict["data"] as? [[String:Any]] {
                    
                    self.journees = dataArray
                    for data in dataArray 	{
                        print("data \(data["nom"]!)")
                    }
                    print(self.journees.count)
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
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        print("Passe dans Segue")
        if segue.identifier == "showDashboardJournee" {
            print("ok")
            
            let dashboardJourneeController = (segue.destination as! DashboardJourneeController)
            
            dashboardJourneeController.journee = self.journee
        }
    }

}

extension ListJourneeController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("ListJournee \(self.journees.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let journee = self.journees[indexPath.row]
        cell.textLabel!.text = journee["nom"] as! String?
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let journee:[String:Any] = self.journees[indexPath.row]
        print(journee["id"]!)
        UserDefaults.standard.set(journee["id"]!, forKey: "idJournee")
        self.journee = self.journees[indexPath.row]
        
        
        performSegue(withIdentifier: "showDashboardJournee", sender: self)
    }
    
    
    
}

