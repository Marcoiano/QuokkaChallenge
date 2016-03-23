//
//  FriendViewCell.swift
//  Quokka
//
//  Created by Marco Tabacchino on 28/11/15.
//  Copyright © 2015 Marco Tabacchino. All rights reserved.
//

import Foundation
import UIKit
class FriendTableViewCell : UITableViewCell {



@IBOutlet weak var profileImage: UIImageView!

@IBOutlet weak var firstNameLabel: UILabel!

@IBOutlet weak var lastNameLabel: UILabel!


@IBOutlet weak var ageLabel: UILabel!


@IBOutlet weak var emailLabel: UILabel!


@IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}