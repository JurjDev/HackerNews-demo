//
//  NewsTableViewCell.swift
//  HackerNews
//
//  Created by JurjDev on 15/04/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var newsTitle: UILabel!
    
    @IBOutlet var newsData: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
