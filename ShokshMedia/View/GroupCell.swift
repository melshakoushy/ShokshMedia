//
//  GroupCell.swift
//  ShokshMedia
//
//  Created by Mahmoud Elshakoushy on 6/2/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var groupCountLbl: UILabel!
    
    func configureCell (title: String, description: String, count: Int) {
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = description
        self.groupCountLbl.text = "\(count) Members."
    }
}
