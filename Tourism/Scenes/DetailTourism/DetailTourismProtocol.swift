//
//  DetailTourismInteractor.swift
//  Tourism
//
//  Created by Adhitya Bagas on 28/08/22.
//

import UIKit

protocol DetailTourismPresenterToInteractorProtocol: AnyObject {
    var tourismDetail: Tourism? { get }
}

protocol DetailTourismViewToPresenterProtocol: AnyObject {
    var router: DetailTourismPresenterToRouterProtocol? { get set }
    var tourismDetail: Tourism? { get set }
}

protocol DetailTourismPresenterToRouterProtocol: AnyObject {
    static func createModule(tourism: Tourism) -> DetailTourismViewController
}
