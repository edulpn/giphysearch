//
//  GifView.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import Foundation

struct GifDisplay {
    var imageUrl : URL
    var date : String
    var source: String
}

protocol GifView {
    
    var gifs : [GifDisplay] {get}
    var gifPresenter : GifPresenter? {get set}
    
    func startLoading()
    func finishLoading()
    func setSearchResult(gifs: [GifDisplay])
    func setSearchError(error: String)
    func setSearchEmpty (message: String)
}
