//
//  ClassementChampionnatController.swift
//  betSwift2
//
//  Created by stagiare on 23/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit
import Alamofire

class ClassementChampionnatController: UIViewController {
    
    let urlString = "http://192.168.56.101/"
    var championnat = [String:Any]()
    var scores = [String:Any]()
    
    var dictionaries = [[String: String]]()
    var res:Any = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let champId:Any = championnat["id"]!
        print(champId)
        
        let token:String? = UserDefaults.standard.object(forKey: "token") as! String?
        if token != nil {
            let headers: HTTPHeaders = ["Accept":"application/json", "Authorization": "Bearer "+token!]
            Alamofire.request(urlString + "api/championnat/\(champId)/score", headers: headers).responseJSON { response in
                print(response.result.value!)
                if let jsonDict = response.result.value as? [String:Any], let dataArray = jsonDict["data"] as? [String:Any] {
                    
                    for (nom, score) in dataArray 	{
                        
                        var dictionary1: [String: String] = ["nom": nom]
                        //dictionary1.updateValue(score as! String, forKey: "score")
                        dictionary1.updateValue("\(score)", forKey: "score")
                        print("dictionary1 \(dictionary1)")

                        self.dictionaries.append(dictionary1)

                    }
                    print("dictionaries \(self.dictionaries)")
                    self.dictionaries = self.dictionaries.reversed()
                    print("after revsrese dictionaries \(self.dictionaries)")
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ClassementChampionnatController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let score = self.dictionaries[indexPath.row]
        cell.textLabel!.text = score["nom"]! + " : " + score["score"]!
        return cell
    }
    
    
    
}
