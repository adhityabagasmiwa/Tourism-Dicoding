//
//  SpecialTourismViewCell.swift
//  Tourism
//
//  Created by Adhitya Bagas on 28/08/22.
//

import UIKit

struct SpecialTourismCell {
    var image: String
    var name: String
    var countLike: Int
}

class SpecialTourismViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLikeLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        mainView.layer.cornerRadius = 16.0
        thumbnailImageView.layer.cornerRadius = 16.0
        thumbnailImageView.clipsToBounds = true
    }
    
    func setData(data: SpecialTourismCell) {
        thumbnailImageView.downloaded(from: data.image)
        titleLabel.text = data.name
        countLikeLabel.text = String(data.countLike)
    }
}
