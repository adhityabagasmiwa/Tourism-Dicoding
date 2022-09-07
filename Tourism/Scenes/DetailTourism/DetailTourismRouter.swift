//
//  DetailTourismRouter.swift
//  Tourism
//
//  Created by Adhitya Bagas on 28/08/22.
//

import UIKit

class DetailTourismRouter: DetailTourismPresenterToRouterProtocol {
    static func createModule(tourism: Tourism) -> DetailTourismViewController {
        let view = DetailTourismViewController()
        
        view.tourism = tourism
        
        return view
    }
}
