//
//  Comic.swift
//  Marvel
//
//  Created by Juan Carrera on 1/7/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Comic: Object, Mappable {
    
    dynamic var uniqueID = 0
    dynamic var title = ""
    dynamic var issueNumber = 0
    dynamic var descriptionText = ""
    dynamic var thumbnail = ""
    dynamic var thumbnailExtension = ""
    dynamic var image = ""
    dynamic var imageExtension = ""


    required convenience init?(_ map: Map) {
        self.init()
    }
    
    
    override static func primaryKey() -> String?{
        return "uniqueID"
    }

    func mapping(map: Map) {
            
        uniqueID            <- map["id"]
        title               <- map["title"]
        issueNumber         <- map["issueNumber"]
        descriptionText     <- map["description"]
        thumbnail           <- map["thumbnail.path"]
        thumbnailExtension  <- map["thumbnail.extension"]
        image               <- map["images.0.path"]
        imageExtension      <- map["images.0.extension"]

    }
    
}