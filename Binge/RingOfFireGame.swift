//
//  RingOfFireGame.swift
//  Binge
//
//  Created by Marco Gravbrøt on 13/06/2017.
//  Copyright © 2017 Marco Gravbrøt. All rights reserved.
//

import UIKit

class RingOfFireGame: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var background: UIView!
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardText: UILabel!
    @IBOutlet weak var cardsLeft: UILabel!
    
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait }
    
    var cards : [[Any]] = []
    var cardsCount = 0
    
    var rules : [String] = [
        "WATERFALL",
        "GIVE TWO",
        "TAKE TWO",
        "GIVE TWO TAKE TWO",
        "MAKE A RULE",
        "THUMB MASTER",
        "HEAVEN",
        "MATE",
        "RHYME TIME",
        "CATEGORIES",
        "DICKS",
        "WHORES",
        "KINGS CUP",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        for cardType in 1...4 {
            for cardNum in 1...13 {
                var finalCardType = String()
                if cardType == 1 {
                    finalCardType = "c"
                } else if cardType == 2 {
                    finalCardType = "h"
                } else if cardType == 3 {
                    finalCardType = "s"
                } else if cardType == 4 {
                    finalCardType = "d"
                }
                
                cards.append([cardNum, UIImage(named: finalCardType + String(cardNum))!])
                //print(finalCardType + String(cardNum))
            }
        }
        
        cards.shuffle()
        
        color = self.getColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextOption(_:)))
        
        self.view.addGestureRecognizer(tapGesture)
        
        backButton.layer.cornerRadius = backButton.frame.height/2
        backButton.layer.masksToBounds = true
        backButton.clipsToBounds = true
        
        backButton.setTitleColor(color, for: .normal)
        background.backgroundColor = color

        titleText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.55)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var beginAnew = false
    
    @IBAction func nextOption(_ sender: UITapGestureRecognizer) {
        if beginAnew {
            cards.shuffle()
            cardsCount = 0
            
            color = self.getColor()
            
            backButton.setTitleColor(color, for: .normal)
            background.backgroundColor = color
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cardImage.image = self.cards[self.cardsCount][1] as? UIImage
                    
                    self.cardText.fadeTransition(0.2)
                    self.cardText.text = self.rules[(self.cards[self.cardsCount][0]) as! Int - 1]
                    
                    self.cardsLeft.fadeTransition(0.2)
                    self.cardsLeft.text = String(51-self.cardsCount)
                    
                    self.color = self.getColor()
                    
                    self.backButton.setTitleColor(self.color, for: .normal)
                    self.background.backgroundColor = self.color
                    
                    self.cardsCount += 1
                }, completion: nil)
            }
            
            beginAnew = false
            
            return
        }
        
        if self.cardsCount == 51 {
            DispatchQueue.main.async {
                self.cardImage.fadeTransition(1)
                self.cardImage.image = UIImage(named: "back")
                
                self.cardText.fadeTransition(1)
                self.cardText.text = "ALL DONE"
                
                self.cardsLeft.fadeTransition(1)
                self.cardsLeft.text = ""
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.cardText.fadeTransition(0.2)
                self.cardText.text = "NEW GAME"
                
                self.beginAnew = true
            })
            
            return
        }
        
        print(self.cardsCount)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.cardImage.image = self.cards[self.cardsCount][1] as? UIImage
                
                self.cardText.fadeTransition(0.2)
                self.cardText.text = self.rules[(self.cards[self.cardsCount][0]) as! Int - 1]
                
                self.cardsLeft.fadeTransition(0.2)
                self.cardsLeft.text = String(51-self.cardsCount)
                
                self.color = self.getColor()
                
                self.backButton.setTitleColor(self.color, for: .normal)
                self.background.backgroundColor = self.color
                
                self.cardsCount += 1
            }, completion: nil)
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.up:
                performSegue(withIdentifier: "OpenRingOfFireHelp", sender: nil)
            default:
                break
            }
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
