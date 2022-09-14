//
//  Define.swift
//  InterviewTask_halal
//
//  Created by iOS on 14/9/22.
//

import Foundation
import UIKit

let DEVICE_HEIGHT = UIScreen.main.bounds.size.height
let DEVICE_WIDTH = UIScreen.main.bounds.size.width

let DELEGATE = UIApplication.shared.delegate as! AppDelegate

func loadVCfromStoryBoard(name: String, identifier: String) -> UIViewController {
    
    if #available(iOS 13.0, *) {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(identifier: identifier)
    } else {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
