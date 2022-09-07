//
//  HomePresenter.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation

class HomePresenter: HomeViewToPresenterProtocol {
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    
    var popularTourism: Home.ShowTourism.ViewModel?
    var specialTourism: Home.ShowTourism.ViewModel?
    
    func fetchTourism() {
        self.interactor?.fetchTourism()
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func specialTourismFetched(response: Home.ShowTourism.Response) {
        let mapped = response.tourism.map {
            Home.ShowTourism.ViewModel.DisplayedTourism(
                image: $0.image ?? "",
                name: $0.name ?? "",
                description: $0.description ?? "",
                address: $0.address ?? "",
                latitude:  String($0.longitude ?? 0.0),
                longitude: String($0.latitude ?? 0.0),
                countLike: $0.like ?? 0
            )
        }
        let sorted = mapped.sorted(by: { $0.countLike > $1.countLike })
        let viewModel = Home.ShowTourism.ViewModel(displayedTourism: sorted)
        specialTourism = viewModel
        view?.showSpecialTourism()
    }
    
    func popularTourismFetched(response: Home.ShowTourism.Response) {
        let mapped = response.tourism.map {
            Home.ShowTourism.ViewModel.DisplayedTourism(
                image: $0.image ?? "",
                name: $0.name ?? "",
                description: $0.description ?? "",
                address: $0.address ?? "",
                latitude:  String($0.longitude ?? 0.0),
                longitude: String($0.latitude ?? 0.0),
                countLike: $0.like ?? 0
            )
        }
        let viewModel = Home.ShowTourism.ViewModel(displayedTourism: mapped)
        popularTourism = viewModel
        view?.showTourism()
    }
    
    func tourismFailedFetched(error: String) {
        view?.showError(error: error)
    }
}
