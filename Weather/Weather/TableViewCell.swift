//
//  TableViewCell.swift
//  Weather
//
//  Created by student on 18.01.15.
//  Copyright (c) 2015 NicolasPfeuffer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
