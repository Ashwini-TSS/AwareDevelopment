//
//  VideohistoryCell.swift
//  Task1
//
//  Created by mac on 22/04/21.
//

import UIKit

class VideohistoryCell: UITableViewCell {
    
    @IBOutlet weak var lbltime: UILabel!
    
    @IBOutlet weak var ViewStartbtn: UIView!
    @IBOutlet weak var ProfileImgview: UIImageView!
    @IBOutlet weak var bgview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
