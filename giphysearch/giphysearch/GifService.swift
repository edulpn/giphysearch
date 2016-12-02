//
//  GifService.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import Foundation

protocol GifService {

    func retrieveGifs(filter: String, success: @escaping ([Gif]) -> Void, failure: @escaping (Error) -> Void)
    func retrieveTrendingGifs(success: @escaping ([Gif]) -> Void, failure: @escaping (Error) -> Void)
}
