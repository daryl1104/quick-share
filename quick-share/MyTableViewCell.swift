//
//  MyTableViewCell.swift
//  quick-share
//
//  Created by daryl on 2023/5/9.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet var myImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
