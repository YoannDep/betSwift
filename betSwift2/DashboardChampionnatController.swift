//
//  DashboardChampionnatController.swift
//  betSwift2
//
//  Created by stagiaire on 23/03/2017.
//  Copyright © 2017 stagiaire. All rights reserved.
//

import UIKit

class DashboardChampionnatController: UIViewController {
    
    var championnat = [String:Any]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClassementTouched(_ sender: UIButton) {
        performSegue(withIdentifier: "showClassement", sender: self)
    }
    
    @IBAction func buttonJourneeTouched(_ sender: UIButton) {
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showClassement" {
            print("passage dans segue DashboardChampionnat")
            let classementChampionnatController = (segue.destination as! ClassementChampionnatController)
            classementChampionnatController.championnat = self.championnat
        }
    }

}
