//
//  SingleArticleTableViewCell.swift
//  Headlines
//
//  Created by Ayemere  Odia  on 2022/11/03.
//  Copyright © 2022 Example. All rights reserved.
//

import UIKit
import SDWebImage
class SingleArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var toplabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
     
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureView(article: Article) {
        iconImage.sd_setImage(with: article.imageURL)
        toplabel.text = article.headline
    }
    
    func configureDate(date: String?) {
        dateLabel.text = date
    }
}
