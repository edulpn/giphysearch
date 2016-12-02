//
//  Utils.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 26/10/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import UIKit

class Utils: NSObject {
    static func date(from: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: from)
    }
    
    static func string(from: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: from)
    }
}

