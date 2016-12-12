//
//  GifPresenter.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import Foundation

protocol GifPresenter {
    
    var view : GifView? {get set}
    var service : GifService {get}
    
    init(service: GifService)
    
    func searchGifs(query: String)
}
