//
//  TableViewCell.swift
//  InstaSaveApplication
//
//  Created by Uğur burak Güven on 3.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewNameLabel: UILabel!
    @IBOutlet weak var tableViewImageView: UIImageView!
    @IBOutlet weak var tableViewDateLabel: UILabel!
    @IBOutlet weak var tableViewCaptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
