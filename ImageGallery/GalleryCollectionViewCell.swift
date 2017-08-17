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
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: self.contentView.frame.width, width: self.contentView.frame.width - 10, height: 20))
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.appVeryDarkBlue
        return label
    }()
    
    fileprivate lazy var authorLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: self.contentView.frame.width + 20, width: self.contentView.frame.width - 10, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.appDarkModerateCyan
        return label
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: self.contentView.frame.width + 40, width: self.contentView.frame.width - 10, height: 20))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.appDarkModerateCyan
        label.textAlignment = .right
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .appVerySoftLimeGreen
        contentView.addSubview(photoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
    }
    
    func setup(photo: GalleryPhoto) {
        guard let imageUrlLink = photo.photoImage?.imageUrlLink, let imageURL = URL(string: imageUrlLink) else {
            return
        }
        photoImageView.kf.setImage(with: ImageResource(downloadURL: imageURL))
        titleLabel.text = photo.title
        authorLabel.text = photo.author
        dateLabel.text = photo.date.prettyDateFormat
    }
    
}
