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
    @IBOutlet weak var backButton: UIButton!
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
        
        backButton.layer.cornerRadius = backButton.frame.height/2
        backButton.layer.masksToBounds = true
        backButton.clipsToBounds = true
        
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
