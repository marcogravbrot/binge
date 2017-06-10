//
//  NeverGame.swift
//  Binge
//
//  Created by Marco Gravbrøt on 09/06/2017. -- wow rly
//  Copyright © 2017 Marco Gravbrøt. All rights reserved.
//

import UIKit

class NeverGame: UIViewController {

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
    
    var neverGame : [String] = [
        "Injured myself while trying to impress a girl or boy I was interested in.",
        "Had to run to save my life.",
        "Taken food out of a trash can and eaten it.",
        "Cried / flirted my way out of a speeding ticket.",
        "Taken part in a talent show.",
        "Made money by performing on the street.",
        "Broken something at a friend’s house and then not told them.",
        "Snooped through a friend’s bathroom or bedroom without them knowing.",
        "Ruined someone else’s vacation.",
        "Walked for more than six hours.",
        "Jumped from a roof.",
        "Shoplifted.",
        "Seen an alligator or crocodile in the wild.",
        "Set my or someone else’s hair on fire on purpose.",
        "Ridden an animal.",
        "Had a bad fall because I was walking and texting.",
        "Been arrested.",
        "Pressured someone into getting a tattoo or piercing.",
        "Gone surfing.",
        "Walked out of a movie because it was bad.",
        "Broken a bone.",
        "Tried to cut my own hair.",
        "Completely forgot my lines in a play.",
        "Shot a gun.",
        "Had a surprise party thrown for me.",
        "Cheated on a test.",
        "Dined and dashed.",
        "Gotten stitches.",
        "Fallen in love at first sight.",
        "Had a paranormal experience.",
        "Woken up and couldn’t move.",
        "Accidentally said “I love you” to someone.",
        "Hitchhiked.",
        "Been trapped in an elevator.",
        "Sung karaoke in front of people.",
        "Been on TV or the radio.",
        "Pressed send and then immediately regretted it.",
        "Been so sun burnt I couldn’t wear a shirt.",
        "Had a crush on a friend’s parent.",
        "Been awake for two days straight.",
        "Thrown up on a roller coaster.",
        "Snuck into a movie.",
        "Accidentally sent someone to the hospital.",
        "Dyed my hair a crazy color.",
        "Had a physical fight with my best friend.",
        "Fallen in love at first sight.",
        "Had someone slap me across the face.",
        "Worked with someone I hated with the burning passion of a thousand suns.",
        "Danced in an elevator.",
        "Cried in public because of a song.",
        "Texted for four hours straight.",
        "Chipped a tooth.",
        "Gone hunting.",
        "Had a tree house.",
        "Thrown something into a TV or computer screen.",
        "Been to a country in Asia.",
        "Been screamed at by a customer at my job.",
        "Spent a night in the woods with no shelter.",
        "Read a whole novel in one day.",
        "Gone vegan.",
        "Been without heat for a winter or without A/C for a summer.",
        "Worn glasses without lenses.",
        "Gone scuba diving.",
        "Lied about a family member dying as an excuse to get out of doing something.",
        "Bungee jumped.",
        "Been to a country in Africa.",
        "Been on a fad diet.",
        "Been to a fashion show.",
        "Been electrocuted.",
        "Stolen something from a restaurant.",
        "Had a bad allergic reaction.",
        "Been in an embarrassing video that was uploaded to YouTube.",
        "Thought I was going to drown.",
        "Worked at a fast food restaurant.",
        "Fainted.",
        "Looked through someone else’s phone without their permission."
    ]
    
    var neverGameCount = Int()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = self.getColor()
        
        neverGame.shuffle()
        neverGameCount = Int(arc4random_uniform(UInt32(neverGame.count)))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextOption(_:)))
        
        self.view.addGestureRecognizer(tapGesture)
        
        backButton.layer.cornerRadius = backButton.frame.height/2
        backButton.layer.masksToBounds = true
        backButton.clipsToBounds = true
        
        backButton.setTitleColor(color, for: .normal)
        background.backgroundColor = color
        
        text.textColor = UIColor.white
        titleText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.55)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextOption(_ sender: UITapGestureRecognizer) {
        if (neverGameCount < neverGame.count) {
            neverGameCount += 1
        } else {
            neverGameCount = 0
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.color = self.getColor()
                
                self.text.fadeTransition(0.2)
                self.text.text = self.neverGame[self.neverGameCount]
                
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
