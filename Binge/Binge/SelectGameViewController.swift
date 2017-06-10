//
//  SelectGameViewController.swift
//  Binge
//
//  Created by Marco Gravbrøt on 09/06/2017.
//  Resources by Martin L Thommesen & Oliver R Jahre
//  Copyright © 2017 Marco Gravbrøt. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}

class SelectGameViewController: UIViewController {
    //@IBOutlet weak var image: UIImageView!

    @IBOutlet weak var gameCount: UIPageControl!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    
    var currentCount = 0
    var gameList : [[Any]] = [
        [
            "NEVER HAVE I EVER",
            "A random statement will appear on screen and you will read it out loud. Anyone who admits to have done what you read out will need to take a drink.",
            "StartNeverGame"
        ],
        [
            "MOST LIKELY TO",
            "A random statement will appear on screen where you will read it out loud. After three seconds everyone will point to the person they believe would be most likely to do what you read out and the one who receives the most votes will take a drink.",
            "StartMostLikely"
        ],
        [
            "TRUTH OR LIE",
            "The phone will be passed around the table. The screen will display TRUTH or LIE and hand you a topic. You will then make up a truth or a lie around the topic and the other players will have guess wether you lied or told the truth. Players who guess wrong will have to drink, and you will have to drink for every player that guess correctly.",
            "StartTruthLie"
        ],
        [
            "UNNAMED GAME",
            "Each round there will appear a random description on screen and the amount you need to name. After you have named one, you pass it on until you have reached the desired amout. If you fail to name the amount in time every player will have to drink. A player can pass but will then have to take a drink.",
            "StartListGame",
        ]
    ]
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let title = gameList[self.currentCount][0]
        let description = gameList[self.currentCount][1]
        
        self.gameTitle.text = title as? String

        self.gameDescription.text = description as? String
        self.gameCount.currentPage = self.currentCount
        
        /*let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 79/255, green: 172/255, blue: 254/255, alpha: 1).cgColor,
            UIColor(red: 0, green: 242/255, blue: 254/255, alpha: 1).cgColor
        ]
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
            print("s1")
            UIView.animate(withDuration: 0.1, animations: {
                print("s2")
                gradientLayer.colors = [
                    UIColor(red: 79/255, green: 172/255, blue: 254/255, alpha: 1).cgColor,
                    UIColor(red: 0, green: 242/255, blue: 254/255, alpha: 1).cgColor
                ]
                
                gradientLayer.locations = [0.0, 1.0]
                gradientLayer.frame = self.view.bounds
                
                self.view.layer.insertSublayer(gradientLayer, at: 0)
            })
        })*/
        
        gameCount.numberOfPages = gameList.count
        
        print(gameCount.numberOfPages)
        print(gameList.count)
        
        /*image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.clipsToBounds = true*/

        // Do any additional setup after loading the view.
    }
    
    func switchGame(title: String, description: String) {
        print(self.currentCount)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.gameTitle.fadeTransition(0.2)
                self.gameTitle.text = title
                
                self.gameDescription.fadeTransition(0.2)
                self.gameDescription.text = description
                self.gameCount.currentPage = self.currentCount
            })
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if (self.currentCount > 0) {
                    self.currentCount -= 1
                
                    let title = gameList[self.currentCount][0]
                    let description = gameList[self.currentCount][1]
                    
                    switchGame(title: title as! String, description: description as! String)
                }
            case UISwipeGestureRecognizerDirection.left:
                if (self.currentCount < self.gameCount.numberOfPages-1) {
                    self.currentCount += 1
 
                    let title = gameList[self.currentCount][0]
                    let description = gameList[self.currentCount][1]
                    
                    switchGame(title: title as! String, description: description as! String)
                }
                
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                
                performSegue(withIdentifier: self.gameList[self.currentCount][2] as! String, sender: nil)
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
