//
//  ProductTableViewCell.swift
//  ios-swift-uitableviewcell-from-xib
//
//  Created by demo on 5/29/18.
//  Copyright © 2018 VNCode247. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    
    @IBOutlet weak var mtView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func defaultUI() {
        // Configure container view appearance
        mtView.layer.cornerRadius = 10
        mtView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        mtView.layer.shadowOpacity = 0.3
        mtView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mtView.layer.shadowRadius = 4
        
        // Configure image view appearance
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
    }
    func configure(with result: Result) {
            // Configure common UI settings here (e.g., corner radius, image content mode)
            
            lbName.font = UIFont.boldSystemFont(ofSize: 16)
            lbName.numberOfLines = 0
            lbName.text = result.title.isEmpty ? "Default Title" : result.title

            lbDesc.font = UIFont.systemFont(ofSize: 14)
            lbDesc.text = result.description.isEmpty ? "Default Description" : result.description

            if let url = URL(string: result.imageURL) {
                img.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
            } else {
                img.image = UIImage(named: "placeholderImage")
            }
        }
    
}
