//
//  PopularTourismViewCell.swift
//  Tourism
//
//  Created by Adhitya Bagas on 17/08/22.
//

import UIKit

struct PopularTourismCell {
    var image: String
    var name: String
    var address: String
    var countLike: Int
}

class PopularTourismViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        mainView.layer.cornerRadius = 16.0
        thumbnailImageView.layer.cornerRadius = 16.0
        thumbnailImageView.clipsToBounds = true
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 32).isActive = true
    }
    
    func setData(data: PopularTourismCell) {
        thumbnailImageView.downloaded(from: data.image)
        titleLabel.text = data.name
        addressLabel.text = data.address
        countLikeLabel.text = String(data.countLike)
    }
}
