//
//  HomeViewInteractor.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation
import RxSwift

class HomeInteractor: HomePresenterToInteractorProtocol {
    
    var presenter: HomeInteractorToPresenterProtocol?
    let disposeBag = DisposeBag()
    
    func fetchTourism() {
        TourismApiConnector.instane.getTourismList().do(onNext: { data in
            let response =  Home.ShowTourism.Response(tourism: data)
            self.presenter?.popularTourismFetched(response: response)
            self.presenter?.specialTourismFetched(response: response)
        }, onError: {error in
            self.presenter?.tourismFailedFetched(error: "\(error)")
        }).subscribe()
            .disposed(by: disposeBag)
    }
}
