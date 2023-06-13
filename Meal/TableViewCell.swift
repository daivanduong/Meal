//
//  TableViewCell.swift
//  Meal
//
//  Created by Ocean97 on 13/06/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCategories: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        viewCell.layer.cornerRadius = 10
        img.layer.cornerRadius = 5
    }
    
}
