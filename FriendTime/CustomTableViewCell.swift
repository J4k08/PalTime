//
//  CustomTableViewCell.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-13.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var surNameLabel: UILabel!

    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
