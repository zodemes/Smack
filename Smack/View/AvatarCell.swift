//
//  AvatarCell.swift
//  Smack
//
//  Created by Tushar Katyal on 20/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
   
    }
    
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    func comfigureCell(index : Int, type : AvatarType) {
        
        if type == .dark {
         avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named : "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
}
