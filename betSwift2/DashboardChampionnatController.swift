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
        print("vue chargée")
        print(self.championnat)

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
