//
//  RecordSubtitleTableViewCell.swift
//  DemoApp
//
//  Created by Abhas on 22/06/21.
//  Copyright © 2021 Abhas. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecordSubtitleTableViewCell: UITableViewCell {
    
    static let identifier = "RecordSubtitleTableViewCell"
    static let nibName = "RecordSubtitleTableViewCell"

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblDisplayName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Property Observers
    var cellObj: JSON? {
        willSet {
            lblName.text = nil
            lblDisplayName.text = nil
        }
        didSet {
            if let obj = cellObj {
                lblName.text = "Name : " + obj["name"].stringValue.capitalized
                lblDisplayName.text = "Description : " + obj["display_name"].stringValue.capitalized
            }
        }
    }
    
}
