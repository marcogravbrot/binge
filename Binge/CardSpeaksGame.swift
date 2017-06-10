//
//  CardSpeaksGame.swift
//  Binge
//
//  Created by Marco Gravbrøt on 10/06/2017.
//  Copyright © 2017 Marco Gravbrøt. All rights reserved.
//

import UIKit

class CardSpeaksGame: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var text: UILabel!
    
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
    
    var cardSpeaks : [String] = [
        "Everyone with black hair must take a drink!",
        "Every cat person has to become a dog person!",
    ]
    
    var cardSpeaksCount = Int()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = self.getColor()
        
        cardSpeaks.shuffle()
        cardSpeaksCount = Int(arc4random_uniform(UInt32(cardSpeaks.count)))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextOption(_:)))
        
        self.view.addGestureRecognizer(tapGesture)
        
        backButton.layer.cornerRadius = backButton.frame.height/2
        backButton.layer.masksToBounds = true
        backButton.clipsToBounds = true
        
        backButton.setTitleColor(color, for: .normal)
        background.backgroundColor = color
        
        text.text = cardSpeaks[cardSpeaksCount]
        text.textColor = UIColor.white
        titleText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.55)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextOption(_ sender: UITapGestureRecognizer) {
        if (cardSpeaksCount < cardSpeaks.count-1) {
            cardSpeaksCount += 1
        } else {
            cardSpeaks.shuffle()
            cardSpeaksCount = 0
        }
        
        print(cardSpeaksCount)
        print(cardSpeaks.count)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.color = self.getColor()
                
                self.text.fadeTransition(0.2)
                self.text.text = self.cardSpeaks[self.cardSpeaksCount]
                
                self.backButton.setTitleColor(self.color, for: .normal)
                self.background.backgroundColor = self.color
            }, completion: nil)
        }
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
