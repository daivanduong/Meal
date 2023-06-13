//
//  MealCategoriesCell.swift
//  Meal
//
//  Created by Ocean97 on 11/06/2023.
//

import UIKit

class MealCategoriesCell: UICollectionViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var viewLb: UIView!
    @IBOutlet weak var categoriesName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCell.layer.cornerRadius = 10
        viewLb.layer.cornerRadius = 10
    }
    
    override var isSelected: Bool {
        didSet {
            self.viewCell.backgroundColor = isSelected ? .black : .white
        }
        
    }

}
