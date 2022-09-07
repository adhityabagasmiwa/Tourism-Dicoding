//
//  ProfileViewController.swift
//  Tourism
//
//  Created by Adhitya Bagas on 17/08/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        setupUI()
        super.viewDidLoad()
    }
    
    private func setupUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
}
