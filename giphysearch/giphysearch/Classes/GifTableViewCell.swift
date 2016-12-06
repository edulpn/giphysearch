//
//  GifTableViewCell.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 05/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class GifTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        self.blurView.addSubview(blurEffectView)
        self.blurView.sendSubview(toBack: blurEffectView)
        blurEffectView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.blurView)
        }
        
        self.gifImageView.contentMode = .scaleAspectFill
    }
    
    func configureGifCell(gifUrl: URL, source: String, date: String) {
        
        self.gifImageView.kf.indicatorType = .activity
        self.gifImageView.kf.setImage(with: gifUrl, options: [.transition(.fade(0.2))])
        self.sourceLabel.text = source
        self.dateLabel.text = date
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
