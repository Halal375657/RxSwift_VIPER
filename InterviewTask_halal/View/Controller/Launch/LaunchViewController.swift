//
//  LaunchViewController.swift
//  InterviewTask_halal
//
//  Created by iOS on 14/9/22.
//

import UIKit

class LaunchViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            DELEGATE.setRootViewController()
        }
    }
}
