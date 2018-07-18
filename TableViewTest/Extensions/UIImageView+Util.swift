//
//  UIImageView+Util.swift
//  TableViewTest
//
//  Created by Chitaranjan sahu on 17/07/18.
//  Copyright © 2018 Chitaranjan sahu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setRoundImage(_ image: UIImage?)  {
        guard let image = image else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.image = image
            strongSelf.roundedImage(10.0)
        }
        
    }
}
private extension UIImageView{
    func roundedImage(_ cornerRadius : CGFloat,withBorder:Bool = true) {
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.cornerRadius  =  cornerRadius
        if withBorder {
            layer.borderColor = UIColor.white.cgColor
        }
        clipsToBounds = true
    }
}
