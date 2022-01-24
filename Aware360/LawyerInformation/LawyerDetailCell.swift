//
//  LawyerDetailCell.swift
//  TaskToday
//
//  Created by mac on 29/05/21.
//

import UIKit

class LawyerDetailCell: UITableViewCell {

    @IBOutlet weak var lblamount: UILabel!
    @IBOutlet weak var lblcases: UILabel!
    @IBOutlet weak var lblyear: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblrating: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imgviewprofile: UIImageView!
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
