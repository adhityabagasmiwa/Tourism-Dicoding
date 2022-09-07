//
//  HomeModel.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation

enum Home {
    enum ShowTourism {
        struct Request {
            var isSpecialTourism: Bool
        }
        
        struct Response {
            var tourism: [Tourism]
        }
        
        struct ViewModel {
            struct DisplayedTourism {
                var image: String
                var name: String
                var description: String
                var address: String
                var latitude: String
                var longitude: String
                var countLike: Int
            }
            
            var displayedTourism: [DisplayedTourism]
        }
    }
}
