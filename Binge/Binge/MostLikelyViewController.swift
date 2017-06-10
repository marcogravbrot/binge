//
//  MostLikelyViewController.swift
//  Binge
//
//  Created by Marco Gravbrøt on 10/06/2017.
//  Resources by Martin L Thommesen & Oliver Ruste Jahren
//  Copyright © 2017 Marco Gravbrøt. All rights reserved.
//

import UIKit

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

class MostLikelyViewController: UIViewController {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var text: UILabel!

    @IBOutlet weak var timerText: UILabel!
    
    var timerCount = 3
    var canSkip = false
    
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
    
    var mostLikely : [String] = [
        "Listen to classical music?",
        "Go to the museum very often?",
        "Be rich?",
        "Be poor?",
        "Have always been the heartbreaker?",
        "Live in a big city?",
        "Watch romantic movies?",
        "Be in a choir?",
        "Be the best at math?",
        "Give all their money to charity?",
        "Be a drama queen?",
        "Marry a celebrity?",
        "Who is most likely always to be happy?",
        "Hold their breath the longest as it possible?",
        "Have the most piercings?",
        "Have weird phobias?",
        "Get married first?",
        "Accidental kill someone?",
        "Die of something stupid?",
        "Embarrass themselves in front of their secret crush / known crush?",
        "Most likely to questions get in a fight?",
        "Fail a simple test?",
        "Become a multi-millionaire?",
        "Punch a wall?",
        "Get arrested for walking around naked?",
        "Fall asleep in class?",
        "Eat with mouth open?",
        "Cry because of a sad movie?",
        "Be the first one to die in a zombie apocalypse?",
        "Worry about small things?",
        "Do the bungee jump?",
        "Talk to animals?",
        "Become a famous actor/actress?",
        "Who is most likely not to have a computer?",
        "Have a part-time job?",
        "Have never been in love?",
        "Smoke?",
        "Do drugs?",
        "Be a stand-up comedian?",
        "Join the military?",
        "Be a supermodel?",
        "Most likely to questions win the lottery?",
        "Rule the world?",
        "Win an Olympic Medal?",
        "Become a high school teacher?",
        "Win an Oscar Award?",
        "Break some world record?",
        "Invent something useful?",
        "Write a best seller?",
        "Be a world traveler?",
        "Be on a commercial?",
        "Become a President of United States of America?",
        "Cause world war?",
        "Who is most likely not to take a shower for a week?",
        "Move to a different country?",
        "Make a million dollars?",
        "Have been the first to kiss a guy/a girl?",
        "Appear on some reality show?",
        "Laugh at a wrong moment?",
        "Take care of the others when they are sick?",
        "Make some change?",
        "Cry in a public place?",
        "Do the plastic surgery?",
        "Marry without love?",
        "Live in a zoo?",
        "Read every book in a school library?",
        "Run away to join the circus?",
        "Spend all their money on something stupid?",
        "Forget important birthdays?"
    ]
    
    var mostLikelyCount = Int()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mostLikely.shuffle()
        mostLikelyCount = Int(arc4random_uniform(UInt32(mostLikely.count)))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextOption(_:)))
        
        color = getColor()
        
        self.view.addGestureRecognizer(tapGesture)
        
        backButton.layer.cornerRadius = backButton.frame.height/2
        backButton.layer.masksToBounds = true
        backButton.clipsToBounds = true
        
        backButton.setTitleColor(color, for: .normal)
        background.backgroundColor = color
        
        text.text = mostLikely[mostLikelyCount]
        text.textColor = UIColor.white
        titleText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.55)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
        })
    }
    
    func timerUpdate() {
        if (timerCount > 0) {
            timerCount -= 1
            timerText.fadeTransition(0.1)
            timerText.text = String(describing: timerCount)
        } else if (timerCount == 0) && (!canSkip) && (timerText.text != "3") {
            canSkip = true
            timerText.fadeTransition(0.3)
            timerText.text = "POINT!"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextOption(_ sender: UITapGestureRecognizer) {
        if !canSkip {
            return
        }
        
        if (mostLikelyCount < mostLikely.count-1) {
            mostLikelyCount += 1
        } else {
            mostLikely.shuffle()
            mostLikelyCount = 0
        }
        
        timerText.fadeTransition(0.2)
        timerText.text = "3"
        
        canSkip = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.timerCount = 3
        })
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.color = self.getColor()
                
                self.text.fadeTransition(0.2)
                self.text.text = self.mostLikely[self.mostLikelyCount]
                    
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
