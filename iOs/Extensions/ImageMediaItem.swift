//
//  ImageMediaItem.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 21/06/2020.
//  Copyright © 2020 ERISCO. All rights reserved.
//

import Foundation
import MessageKit

struct ImageMediaItem: MediaItem {

    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize

    init(image: UIImage) {
        self.image = image
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage()
    }

}
