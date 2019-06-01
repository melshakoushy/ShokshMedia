//
//  UserCell.swift
//  ShokshMedia
//
//  Created by Mahmoud Elshakoushy on 5/29/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var showing = false
    
    func configureCell(email: String, profileImage: UIImage, isSelected: Bool) {
        self.emailLbl.text = email
        self.userImage.image = profileImage
        if isSelected {
           self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
                } else {
            checkImage.isHidden = true
            showing = false
        }
    }

}
}
