//
//  LoginViewController.swift
//  IntSocialInstagramLogin
//
//  Created by Vinod Tiwari on 22/05/19.
//  Copyright © 2019 Intellarc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func bnLogin (_ sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
