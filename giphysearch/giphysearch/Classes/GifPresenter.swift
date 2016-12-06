//
//  GifPresenter.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import Foundation

protocol GifPresenter {
    
    var view : GifView {get}
    var service : GifService {get}
    
    init(view: GifView, service: GifService)
    
    func searchGifs(query: String)
}
