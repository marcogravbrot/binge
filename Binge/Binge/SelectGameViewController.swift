//
//  SelectGameViewController.swift
//  Binge
//
//  Created by Marco Gravbrøt on 09/06/2017.
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
            "A random statement will be put on the screen where the announcer will read it out loud. Anyone who has done the statement has to take a drink.",
            "StartNeverGame"
        ],
        [
            "MOST LIKELY TO",
            "A random statement will be put on the screen where the announcer will read it out. After 3 seconds everyone will point on the person they believe would be most likely to do the statement. The one who receives the most votes has to take a drink.",
            "StartMostLikely"
        ],
        [
            "TRUTH OR LIE",
            "The phone will be passed around the table. The screen will say TRUTH or LIE and give you a topic. You will then have to create a truth or a lie around the topic where the other players will guess wether you lied or told a truth. Players who guess wrong will have to drink, and you will have to drink for every player that guessed correctly.",
            "StartTruthLie"
        ],
        [
            "UNNAMED GAME",
            "Every turn a selected description will be given and the amount of items you have to name that fit the description. Someone beings first, and then rotate clockwise or anti-clockwise. You name one item until you have named as many it asks for. If you fail to do this in time every player will have to drink. Any player can say ´Pass! but then that player has to take a drink while the game continues",
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
