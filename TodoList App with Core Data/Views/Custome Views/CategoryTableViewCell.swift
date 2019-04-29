//
//  CategoryTableViewCell.swift
//  TodoList App with Core Data
//
//  Created by Kemo on 4/27/19.
//  Copyright © 2019 kodechamp. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryValueLabel: UILabel!
    @IBOutlet weak var completionValueLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryNameValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
