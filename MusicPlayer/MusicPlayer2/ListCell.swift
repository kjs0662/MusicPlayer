//
//  ListCell.swift
//  MusicPlayer2
//
//  Created by 김진선 on 2017. 12. 16..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.albumImageView.clipsToBounds = true
        self.albumImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(image: UIImage, title: String, artist: String) {
        self.albumImageView.image = image
        self.titleLabel.text = title
        self.artistLabel.text = artist
    }

}
