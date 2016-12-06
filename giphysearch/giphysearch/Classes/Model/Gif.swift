//
//  Gif.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 26/10/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import SwiftyJSON

class Gif: NSObject {
    
    var id : String
    var importDate : Date?
    var source : String
    var url : String
    var downSampledGifUrl : String
    
    init(json: JSON) {

        self.id = json["id"].stringValue
        self.importDate = Utils.date(from: json["import_datetime"].stringValue)
        self.source = json["source"].stringValue
        self.url = json["url"].stringValue
        self.downSampledGifUrl = json["images"]["fixed_height_downsampled"]["url"].stringValue
    }
}
