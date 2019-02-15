//
//  AttendetCompanyTableViewCell.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 15/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class AttendedCompanyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var count: StyleButton!
    @IBOutlet weak var comment: StyleButton!
    
    var id : Int64!
}
