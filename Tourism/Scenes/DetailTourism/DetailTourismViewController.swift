//
//  DetailTourismViewController.swift
//  Tourism
//
//  Created by Adhitya Bagas on 28/08/22.
//

import UIKit

class DetailTourismViewController: UIViewController {

    @IBOutlet weak var mainThumbnailView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var tourism: Tourism?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
        configureNavigationBar(backgoundColor: primaryColor!, tintColor: .white, leftTitle: "Detail Tourism")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    private func setData() {
        thumbnailImageView.downloaded(from: self.tourism?.image ?? "")
        titleLabel.text = self.tourism?.name ?? ""
        locationLabel.text = self.tourism?.address ?? ""
        likeCountLabel.text = "\(self.tourism?.like ?? 0) Like"
        descriptionLabel.text = self.tourism?.description ?? ""
    }
}
