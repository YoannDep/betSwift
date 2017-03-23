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
    var invitations = [[String:Any]]()
    var invitation = [String:Any]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var invitationTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let token:String? = UserDefaults.standard.object(forKey: "token") as! String?
        if token != nil {
            print("Token Main View")
            let headers: HTTPHeaders = ["Accept":"application/json", "Authorization": "Bearer "+token!]
            
            
            Alamofire.request(urlString + "api/championnat/invit", headers: headers).responseJSON { response in
                print("Inivtation \(response.result.value)")
                if let jsonDict = response.result.value as? [String:Any],
                    let dataArray = jsonDict["data"] as? [[String:Any]] {
                    
                    self.invitations = dataArray
                    for data in dataArray 	{
                        print("data \(data["nom"]!)")
                    }
                    print(self.invitations.count)
                    self.invitationTableView.reloadData()
                }
            }
            
            

            
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
        
        self.invitationTableView.reloadData()
        self.tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        invitationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellInvit")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier == "showChampionnat" {
           // let dashboardChampionnatController = (segue.destination as! DashboardChampionnatController)
            let dashboardChampionnatController = (segue.destination as! UINavigationController).topViewController as! DashboardChampionnatController

            dashboardChampionnatController.championnat = self.championnat
        }
    }
}


extension MainViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.tableView {
            count = championnats.count
        }
        
        if tableView == self.invitationTableView {
            count =  invitations.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.invitationTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellInvit", for: indexPath)
            let invitation = self.invitations[indexPath.row]
            cell.textLabel!.text = invitation["nom"] as! String?
            return cell

            
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let championnat = self.championnats[indexPath.row]
            cell.textLabel!.text = championnat["nom"] as! String?
            cell
            return cell

            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.tableView {

            let championnat:[String:Any] = self.championnats[indexPath.row]
            print(championnat["id"]!)
            self.championnat = self.championnats[indexPath.row]
            performSegue(withIdentifier: "showChampionnat", sender: self)
        }
    }
}
