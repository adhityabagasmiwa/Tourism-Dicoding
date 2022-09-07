//
//  SpecialTourismCell.swift
//  Tourism
//
//  Created by Adhitya Bagas on 17/08/22.
//

import UIKit

struct SpecialTourismCell {
    var thumbnailImage: String
    var name: String
    var address: String
    var countLike: Int
}

class SpecialTourismsiewxCell: UICollectionViewCell {
    
//    @IBOutlet weak var thumbnailImage: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var addressLabel: UILabel!
//    @IBOutlet weak var countLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data: SpecialTourismCell) {
        thumbnailImage.downloaded(from: data.thumbnailImage)
        titleLabel.text = data.name
        addressLabel.text = data.address
        countLikeLabel.text = String(data.countLike)
    }
}

