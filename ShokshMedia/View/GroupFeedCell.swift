//
//  GroupFeedCell.swift
//  ShokshMedia
//
//  Created by Mahmoud Elshakoushy on 6/14/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(image: UIImage, email: String, content: String){
        self.profileImage.image = image
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
}
