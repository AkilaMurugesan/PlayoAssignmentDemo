//
//  NewsTableViewCell.swift
//  PlayoAssignment
//
//  Created by Akila Arun on 7/15/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var viewCorner: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
