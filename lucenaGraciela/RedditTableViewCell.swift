//
//  RedditTableViewCell.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {

    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var comments: UILabel!
    @IBOutlet var subreddit: UILabel!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.cornerRadius = 10
        thumbnail.clipsToBounds = true
        thumbnail.layer.borderWidth = 1.0
        thumbnail.layer.borderColor = UIColor.lightGray.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
