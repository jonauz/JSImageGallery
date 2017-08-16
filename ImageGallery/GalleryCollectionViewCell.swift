//
//  GalleryCollectionViewCell.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let cellReuseIdentifier = "galleryReuseIdentifier"
    
    fileprivate lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.width))
        view.backgroundColor = .clear
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .appSlightlyDesaturatedCyanLimeGreen
        contentView.addSubview(photoImageView)
    }
    
    func setup(photo: GalleryPhoto) {
        print(photo)
        guard let imageUrlLink = photo.photoImage?.imageUrlLink, let imageURL = URL(string: imageUrlLink) else {
            return
        }
        photoImageView.kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
    
}
