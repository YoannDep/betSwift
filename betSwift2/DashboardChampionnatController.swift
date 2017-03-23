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
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("vue chargée")
        print(self.championnat)
        nameLbl.text = self.championnat["nom"] as! String?

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier == "showInvitation" {
            // let dashboardChampionnatController = (segue.destination as! DashboardChampionnatController)
            let invitationController = (segue.destination as! InvitationController)
            
            invitationController.championnat = self.championnat
        }
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
