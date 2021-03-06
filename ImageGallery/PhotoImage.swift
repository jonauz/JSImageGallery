//
//  PhotoImage.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import Foundation
import ObjectMapper

struct PhotoImage {
    var imageUrlLink: String = ""
}

extension PhotoImage: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        imageUrlLink <- map["m"]
    }
}
