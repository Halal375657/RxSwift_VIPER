//
//  RootNavViewController.swift
//  InterviewTask_halal
//
//  Created by iOS on 14/9/22.
//

import UIKit

class RootNavViewController: UINavigationController {

    var isStatusBarHide : Bool = true
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
    }

}

class HomeNavViewController: UINavigationController {

    var isStatusBarHide : Bool = false
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
    }

}
