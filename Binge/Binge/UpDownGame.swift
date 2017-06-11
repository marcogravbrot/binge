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
    
    @IBOutlet weak var firstCard: UIImageView!
    @IBOutlet weak var secondCard: UIImageView!
    
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
    
    var cards : [[Any]] = []
    var cardsCount = 0
    
    var block = UIView()
    var label = UILabel()
    
    var isGuessing = true

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        self.view.addGestureRecognizer(tapGesture)
        
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
            
        firstCard.image = cards[cardsCount][1] as? UIImage
        secondCard.image = UIImage(named: "back")
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
            self.block = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            self.block.backgroundColor = UIColor.clear
            self.block.isUserInteractionEnabled = false
    
            self.view.addSubview(self.block)
            
            self.label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            self.label.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            self.label.textAlignment = .center
            self.label.text = "DRINK!"
            self.label.font = UIFont(name: "AvenirNext-Bold", size: 72)
            self.label.textColor = UIColor.clear
            self.label.isUserInteractionEnabled = false
            
            self.view.addSubview(self.label)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextOption(up: Bool) {
        if cardsCount == cards.count-1 {
            cardsCount = 0
        }
        
        if isGuessing {
            var firstCardCount = cards[cardsCount][0] as? Int
            
            cardsCount += 1
            
            var secondCardCount = cards[cardsCount][0] as? Int
            
            if firstCardCount == 1 {
                firstCardCount = 14
            }
            
            if secondCardCount == 1 {
                secondCardCount = 14
            }
            
            secondCard.fadeTransition(0.2)
            secondCard.image = cards[cardsCount][1] as? UIImage
            
            //print(String(describing: firstCardCount))
            //print(String(describing: secondCardCount))
            
            if !(secondCardCount == firstCardCount) {
                if up {
                    if secondCardCount! > firstCardCount! {
                        print("true")
                    } else {
                        self.block.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                        self.label.textColor = UIColor.white
                    }
                } else {
                    if secondCardCount! < firstCardCount! {
                        print("true")
                    } else {
                        self.block.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                        self.label.textColor = UIColor.white
                    }
                }
            } else {
                print("true (equal)")
            }
            
            DispatchQueue.main.async {
                self.upButton.isHidden = true
                self.downButton.isHidden = true
            }
            
            isGuessing = false
        } else {
            isGuessing = true
        
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, animations: {
                    self.color = self.getColor()
                
                    self.backButton.setTitleColor(self.color, for: .normal)
                    self.background.backgroundColor = self.color
                    
                    self.firstCard.fadeTransition(0.2)
                    self.firstCard.image = self.secondCard.image
                    
                    self.secondCard.fadeTransition(0.2)
                    self.secondCard.image = UIImage(named: "back")
                    
                    self.upButton.isHidden = false
                    self.downButton.isHidden = false
                    
                    self.block.backgroundColor = UIColor.clear
                    self.label.textColor = UIColor.clear
                }, completion: nil)
            }
        }
    }
    
    func tapScreen() {
        if isGuessing {
            return
        }
        
        nextOption(up: false)
    }
    
    @IBAction func upButtonPress(_ sender: Any) {
        nextOption(up: true)
    }
    
    @IBAction func downButtonPress(_ sender: Any) {
        nextOption(up: false)
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
