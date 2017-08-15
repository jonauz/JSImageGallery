//
//  GalleryCollectionViewCell.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let cellReuseIdentifier = "galleryReuseIdentifier"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .appSlightlyDesaturatedCyanLimeGreen
    }
    
}
