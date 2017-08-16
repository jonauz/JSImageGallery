//
//  GalleryPhoto.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import Foundation
import ObjectMapper

struct GalleryPhoto {
    var title: String = ""
    var link: String = ""
    var photoImage: PhotoImage?
    var description: String = ""
    var published: String = ""
    var author: String = ""
    var dateTaken: String = ""
}

extension GalleryPhoto: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        link <- map["link"]
        photoImage <- map["media"]
        description <- map["description"]
        published <- map["published"]
        author <- map["author"]
        dateTaken <- map["date_taken"]
    }
}

extension GalleryPhoto: Equatable {}

//MARK: - Equatable Protocol implementation
func ==(lhs: GalleryPhoto, rhs: GalleryPhoto) -> Bool {
    return (lhs.title == rhs.title
        && lhs.link == rhs.link
        && lhs.photoImage != nil
        && rhs.photoImage != nil
        && lhs.photoImage!.imageUrlLink == rhs.photoImage!.imageUrlLink
        && lhs.description == rhs.description
        && lhs.published == rhs.published
        && lhs.author == rhs.author
        && lhs.dateTaken == rhs.dateTaken
    )
}

extension GalleryPhoto: Hashable {
    var hashValue: Int {
        return self.link.hashValue
    }
}
