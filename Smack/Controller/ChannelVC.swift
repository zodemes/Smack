//
//  ChannelVC.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
