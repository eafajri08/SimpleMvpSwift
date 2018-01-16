//
//  NewsListTableViewCell.swift
//  MyNews
//
//  Created by eafajri on 1/9/18.
//  Copyright © 2018 Erric Alfajri. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = .disclosureIndicator
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellView(with data: NewsListModel) {
        
        titleLabel.text = data.title!
        authorLabel.text = data.author!
        publishedAtLabel.text = data.publishedAt!
        
    }

}
