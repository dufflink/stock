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
    var isRated : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data : AttendedCompanyData) {
        print("Ссылки на картинки \(data.pictureUrl)")

        picture.loadPicture(url: data.pictureUrl)
        title.text = data.title
        count.setTitle(data.count, for: .normal)
        isRated = data.isRated
        id = data.companyId
        comment.isHidden = isRated == 1 ? true : false
    }
}
