//
//  ViewController.swift
//  CDFlipViewDemo
//
//  Created by jibeex on 1/20/16.
//  Copyright © 2016 Jianbin LIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var flipViewContainer:UIView!
    @IBOutlet var flipView:CDFlipView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.flipViewContainer.layer.cornerRadius = self.flipViewContainer.bounds.width/2
        
        var imageSet:[UIImageView] = [] // Use any object of type UIView
        
        for index in 1...5{
            let image = UIImageView(image: UIImage(named: "\(index)"))
            image.contentMode = .ScaleAspectFill
            imageSet.append(image)
        }
        
        flipView.layer.zPosition = 100
        flipView.durationForOneTurnOver = 0.6
        flipView.stillTime = 0.1
        flipView.setUp(imageSet)
        flipView.startAnimation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

