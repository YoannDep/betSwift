//
//  MainViewController.swift
//  betSwift2
//
//  Created by stagiaire on 21/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire


class MainViewController: UIViewController {

    let urlString = "http://192.168.56.101/"
    var championnats = [[String:Any]]()
    var championnat = [String:Any]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let token:String? = UserDefaults.standard.object(forKey: "token") as! String?
        if token != nil {
            print("Token Main View")
            let headers: HTTPHeaders = ["Accept":"application/json", "Authorization": "Bearer "+token!]
            
            
            Alamofire.request(urlString + "api/championnat", headers: headers).responseJSON { response in
                //print(response.result.value)
                if let jsonDict = response.result.value as? [String:Any],
                    let dataArray = jsonDict["data"] as? [[String:Any]] {
                    
                    self.championnats = dataArray
                    for data in dataArray 	{
                        print("data \(data["nom"]!)")
                    }
                    print(self.championnats.count)
                    self.tableView.reloadData()
                }
            }
        }
        else{
            print("else")
        }
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
        if segue.identifier == "showChampionnat" {
            let dashboardChampionnatController = (segue.destination as! DashboardChampionnatController)
            dashboardChampionnatController.championnat = self.championnat
        }
    }
}


extension MainViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championnats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Championnat count :")
        print("tableView \(self.championnats.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let championnat = self.championnats[indexPath.row]
        cell.textLabel!.text = championnat["nom"] as! String? // championnat["nom"]
        // cell.textLabel?.text = championnats[indexPath.row].value(forKeyPath: "name") as? //String // recherche pour l'attribut name en BDD
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let championnat:[String:Any] = self.championnats[indexPath.row]
//        print("champ Id champ : \(championnat["id"]) ")
//        UserDefaults.standard.set(championnat["id"], forKey: "idChamp")
        self.championnat = self.championnats[indexPath.row]
        performSegue(withIdentifier: "showChampionnat", sender: self)
    }
    
    
    
}
