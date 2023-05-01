//
//  ViewController.swift
//  CatchBUPE
//
//  Created by B. on 27/04/2023.
//

import UIKit

class ViewController: UIViewController {
    
//variables
    var score = 0
    var timer = Timer ()
    var counter = 0
    var bupeArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
//views
    @IBOutlet weak var timeLAbel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var bupe1: UIImageView!
    @IBOutlet weak var bupe2: UIImageView!
    @IBOutlet weak var bupe3: UIImageView!
    @IBOutlet weak var bupe4: UIImageView!
    @IBOutlet weak var bupe5: UIImageView!
    @IBOutlet weak var bupe6: UIImageView!
    @IBOutlet weak var bupe7: UIImageView!
    @IBOutlet weak var bupe8: UIImageView!
    @IBOutlet weak var bupe10: UIImageView!
    @IBOutlet weak var bupe11: UIImageView!
    @IBOutlet weak var bupe12: UIImageView!
    @IBOutlet weak var bupe9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        //images
        scoreLabel.text = "Score: \(score)"
        bupe1.isUserInteractionEnabled = true
        bupe2.isUserInteractionEnabled = true
        bupe3.isUserInteractionEnabled = true
        bupe4.isUserInteractionEnabled = true
        bupe5.isUserInteractionEnabled = true
        bupe6.isUserInteractionEnabled = true
        bupe7.isUserInteractionEnabled = true
        bupe8.isUserInteractionEnabled = true
        bupe9.isUserInteractionEnabled = true
        bupe10.isUserInteractionEnabled = true
        bupe11.isUserInteractionEnabled = true
        bupe12.isUserInteractionEnabled = true
        
        let recogniser1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser10 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser11 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser12 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        bupe1.addGestureRecognizer(recogniser1)
        bupe2.addGestureRecognizer(recogniser2)
        bupe3.addGestureRecognizer(recogniser3)
        bupe4.addGestureRecognizer(recogniser4)
        bupe5.addGestureRecognizer(recogniser5)
        bupe6.addGestureRecognizer(recogniser6)
        bupe7.addGestureRecognizer(recogniser7)
        bupe8.addGestureRecognizer(recogniser8)
        bupe9.addGestureRecognizer(recogniser9)
        bupe10.addGestureRecognizer(recogniser10)
        bupe11.addGestureRecognizer(recogniser11)
        bupe12.addGestureRecognizer(recogniser12)
        
        bupeArray = [bupe1,bupe2, bupe3, bupe4, bupe5, bupe6, bupe7, bupe8, bupe9, bupe10, bupe11, bupe12]
        
        //timers
        
        counter = 10
        timeLAbel.text = String(counter)
        //kac saniyede bir ne yapacagimizi yazmak icin scheduled olani kullaniyorsun
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideBupe), userInfo: nil, repeats: true)
        //saklayacagiz
        hideBupe()
        
        
    }
      @objc func hideBupe() {
            for bupe in bupeArray {
                bupe.isHidden = true
        }
        
           let random = Int(arc4random_uniform(UInt32((bupeArray.count-1))))
            bupeArray[random].isHidden = false
    }
    
    @objc func increaseScore () {
        score += 1
        scoreLabel.text = "Score: \(score) "
    }
    
    @objc func countDown() {
        counter -= 1
        timeLAbel.text = String(counter)
        
        if counter == 0{ //invalidate durdurmak icin
            timer.invalidate()
            hideTimer.invalidate()
//HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
//Alert
            
            let alert = UIAlertController(title: "Time's UP!!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertController(title: "OK", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {(UIAlertAction) in
                
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLAbel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBupe), userInfo: nil, repeats: true)
            }
           /* alert.addAction(okButton)
            alert.addAction(replayButton)
            //alerti gostermek icin self.present kullaniyoruz
            self.present(alert, animated: true, completion: nil) */
        }
    }
    
    }

   

