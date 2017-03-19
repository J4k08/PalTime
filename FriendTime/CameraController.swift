//
//  CameraController.swift
//  FriendTime
//
//  Created by Jakob Haglöf on 2017-03-13.
//  Copyright © 2017 Jakob Haglöf. All rights reserved.
//

import Foundation
import UIKit

class CameraController {
    
    private init(){
        
    }
    
    
    class func getPicture(imagePath : String) -> UIImage{
        var img = UIImage()
        
        if let image = UIImage(contentsOfFile: imagePath) {
            NSLog("Image found.")
            img = image
            
        }
        else {
            NSLog("No image was found.")
        }
        return img
    
    }
    
    class func imagePath(nameOfImage : String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first {
            
            return documentsDirectory.appending("/\(nameOfImage).png")
            
        }else {
            fatalError("No documents directory :(((")
        }
    }
    
}
