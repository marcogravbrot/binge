//
//  UpDownGame.swift
//  Binge
//
//  Created by Marco Gravbrøt on 11/06/2017.
//  Copyright © 2017 Marco Gravbrøt. All rights reserved.
//

import UIKit

class UpDownGame: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var background: UIView!
    
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    
    var colors : [UIColor] = [
        UIColor(red: 0, green: 120/255, blue: 1, alpha: 1),
        UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1),
        
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0),
        UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0),
        UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1.0),
        UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0),
        UIColor(red: 211/255, green: 84/255, blue: 0/255, alpha: 1.0),
        UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
    ]
    
    var color = UIColor()
    
    func getColor() -> UIColor {
        return colors[Int(arc4random_uniform(UInt32(Int(colors.count))))]
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = self.getColor()
        
        backButton.layer.cornerRadius = backButton.frame.height/2
        backButton.layer.masksToBounds = true
        backButton.clipsToBounds = true
        
        backButton.setTitleColor(color, for: .normal)
        background.backgroundColor = color
        
        titleText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.55)
        
        // Up/Down Buttons
        
        downButton.backgroundColor = UIColor.clear
        downButton.layer.borderWidth = 4
        downButton.layer.borderColor = UIColor.white.cgColor
        downButton.layer.cornerRadius = downButton.frame.width/2
        downButton.layer.masksToBounds = true
        downButton.clipsToBounds = true
        
        upButton.backgroundColor = UIColor.clear
        upButton.layer.borderWidth = 4
        upButton.layer.borderColor = UIColor.white.cgColor
        upButton.layer.cornerRadius = upButton.frame.width/2
        upButton.layer.masksToBounds = true
        upButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextOption() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.color = self.getColor()
                
                self.backButton.setTitleColor(self.color, for: .normal)
                self.background.backgroundColor = self.color
            }, completion: nil)
        }
    }
    
    @IBAction func upButtonPress(_ sender: Any) {
        nextOption()
    }
    
    @IBAction func downButtonPress(_ sender: Any) {
        nextOption()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
