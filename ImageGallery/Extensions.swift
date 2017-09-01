//
//  Extensions.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import UIKit


// MARK: - Predifined app colors
extension UIColor {
    
    /// Hex: #a8dba8
    static var defaultVerySoftLimeGreen: UIColor {
        return UIColor(red: 0.659, green: 0.859, blue: 0.659, alpha: 1)
    }
    
    /// Hex: #79bd9a
    static var defaultSlightlyDesaturatedCyanLimeGreen: UIColor {
        return UIColor(red: 0.475, green: 0.741, blue: 0.604, alpha: 1)
    }
    
    /// Hex: #3b8686
    static var defaultDarkModerateCyan: UIColor {
        return UIColor(red: 0.231, green: 0.525, blue: 0.525, alpha: 1)
    }
    
    /// Hex: #0b486b
    static var defaultVeryDarkBlue: UIColor {
        return UIColor(red: 0.043, green: 0.282, blue: 0.42, alpha: 1)
    }
    
}

// MARK: Date helpers
extension Date {
    
    var prettyDateFormat: String {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formater.string(from: self)
    }
    
}

extension String {
    
    var convertToDate: Date? {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formater.date(from: self)
    }
    
}
