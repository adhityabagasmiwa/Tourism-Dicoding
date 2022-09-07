//
//  TourismApiConnector.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation
import RxSwift

class TourismApiConnector: ApiConnector {
    static let instane = TourismApiConnector()
    
    private var API_GET_TOURISM_LIST = "/list"
    
    func getTourismList() -> Observable<[Tourism]> {
        var result: [Tourism] = []
        let request = manager.request(API_GET_TOURISM_LIST, method: .get)
        
        return request.rx_JSON().mapJSONResponse().map { response in
            if response.result["places"].exists() {
                for data in response.result["places"].arrayValue {
                    if let item = Tourism.with(json: data) {
                        result.append(item)
                    }
                }
            }
            return result
        }
    }
}
