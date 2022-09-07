//
//  HomeProtocol.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation
import UIKit

protocol HomePresenterToInteractorProtocol: AnyObject {
    var presenter: HomeInteractorToPresenterProtocol? { get set }

    func fetchTourism()
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func popularTourismFetched(response: Home.ShowTourism.Response)
    func specialTourismFetched(response: Home.ShowTourism.Response)
    
    func tourismFailedFetched(error: String)
}

protocol HomePresenterToViewProtocol: AnyObject {
    func showTourism()
    func showSpecialTourism()
    
    func showError(error: String)
}

protocol HomeViewToPresenterProtocol: AnyObject {
    var view: HomePresenterToViewProtocol? { get set }
    var interactor: HomePresenterToInteractorProtocol? { get set }
    var popularTourism: Home.ShowTourism.ViewModel? { get }
    var specialTourism: Home.ShowTourism.ViewModel? { get }

    func fetchTourism()
}
