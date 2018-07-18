//
//  UIImage+Util.swift
//  TableViewTest
//
//  Created by Chitaranjan sahu on 17/07/18.
//  Copyright © 2018 Chitaranjan sahu. All rights reserved.
//

import Foundation
import UIKit
extension UIImage{
    static func downloadImageFromUrl(_ url :String,completionHandler: @escaping (UIImage?)->Void){
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        let task :URLSessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) ->Void in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    completionHandler(nil)
                    return
            }
            completionHandler(image)
        }
        task.resume()
        
    }
}
