//
//  UIImageView+URL.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
    
    func loadImage(with imageURL: URL, placeholderImage: UIImage?) {
        af_setImage(withURL: imageURL, placeholderImage: placeholderImage)
    }
}
