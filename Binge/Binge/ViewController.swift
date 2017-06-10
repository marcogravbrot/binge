//
//  ViewController.swift
//  Binge
//
//  Created by Marco Gravbrøt on 09/06/2017.
//  Copyright © 2017 Marco Gravbrøt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playButton.layer.cornerRadius = playButton.frame.height/2
        playButton.layer.masksToBounds = true
        playButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
