//
//  CollisionTableViewCell.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 05.02.21.
//

import UIKit

class CollisionTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model: CollisionViewModel? {
        didSet {
            if let pair = model?.pair {
                frontLabel.text = pair.frontEmployee.name
                backLabel.text = pair.backEmployee.name
            }
        }
    }

}
