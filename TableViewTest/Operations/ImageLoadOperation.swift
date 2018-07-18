//
//  ImageLoadOperation.swift
//  TableViewTest
//
//  Created by Chitaranjan sahu on 17/07/18.
//  Copyright © 2018 Chitaranjan sahu. All rights reserved.
//

import Foundation
import UIKit
typealias ImageLoadOperationCompletionHandlerType = ((UIImage) -> ())?
class ImageLoadOperation: Operation{
    var url:String
    var completionHandler : ImageLoadOperationCompletionHandlerType
    var image : UIImage?
    init(url:String) {
        self.url = url
    }
    override func main() {
        if isCancelled{
            return
        }
        UIImage.downloadImageFromUrl(url) { [weak self](image) in
            guard let strongself = self, !strongself.isCancelled,
                let image = image else {
                    return
            }
            strongself.image = image
            strongself.completionHandler?(image)
            
        }
    }
    
}
