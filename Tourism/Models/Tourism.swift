//
//  Tourism.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation
import SwiftyJSON

struct Tourism {
    var id: Int?
    var name: String?
    var description: String?
    var address: String?
    var longitude: Double?
    var latitude: Double?
    var like: Int?
    var image: String?
    
    static func with(json: JSON) -> Tourism? {
        var item = Tourism()
        
        if json["id"].exists() {
            item.id = json["id"].int
        }
        
        if json["name"].exists() {
            item.name = json["name"].string
        }
        
        if json["description"].exists() {
            item.description = json["description"].string
        }
        
        if json["address"].exists() {
            item.address = json["address"].string
        }
        
        if json["longitude"].exists() {
            item.longitude = json["longitude"].double
        }
        
        if json["latitude"].exists() {
            item.latitude = json["latitude"].double
        }
        
        if json["like"].exists() {
            item.like = json["like"].int
        }
        
        if json["image"].exists() {
            item.image = json["image"].string
        }
        
        return item
    }
}
