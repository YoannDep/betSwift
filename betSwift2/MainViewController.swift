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
    let championnats = [Any]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        let token:String? = UserDefaults.standard.object(forKey: "token") as! String?
        let headers: HTTPHeaders = ["Accept":"application/json", "Authorization": "Bearer "+token!]
        
        
        Alamofire.request(urlString + "api/championnat", headers: headers).responseJSON { response in
            if let result:[[String:Any]] = response.result.value as? [[String:Any]] {
                print(response.result.value)
                for champ:[String:Any] in result {
                    print(champ["nom"])
                }
            } else {
                print("erreur")
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//            print("value = \(key) = \(value) \n")
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



extension MainViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championnats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let championnat = self.championnats[indexPath.row]
        cell.textLabel!.text = "Test" // championnat["nom"]
       // cell.textLabel?.text = championnats[indexPath.row].value(forKeyPath: "name") as? //String // recherche pour l'attribut name en BDD
        return cell
    }
    
    
}
