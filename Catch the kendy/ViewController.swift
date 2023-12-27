import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var time = Timer()
    var hideTimer = Timer()
    var counter = 0
    var kendyArray = [UIImageView]()
    var hightscore = 0
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var hightscoreLable: UILabel!
    @IBOutlet weak var kendy1: UIImageView!
    @IBOutlet weak var kendy2: UIImageView!
    @IBOutlet weak var kendy3: UIImageView!
    @IBOutlet weak var kendy4: UIImageView!
    @IBOutlet weak var kendy5: UIImageView!
    @IBOutlet weak var kendy6: UIImageView!
    @IBOutlet weak var kendy7: UIImageView!
    @IBOutlet weak var kendy8: UIImageView!
    @IBOutlet weak var kendy9: UIImageView!
    @IBOutlet weak var kendy10: UIImageView!
    @IBOutlet weak var kendy11: UIImageView!
    @IBOutlet weak var kendy12: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHightScore = UserDefaults.standard.object(forKey: "hightscore")
        
        if storedHightScore == nil {
            hightscore = 0
            hightscoreLable.text = "HightScore: \(hightscore)"
        }
        
        if let newScore = storedHightScore as? Int {
            hightscore = newScore
            hightscoreLable.text = "HightScore: \(hightscore)"
        }
        
        scoreLable.text = "Điểm: \(score)"
        
        kendy1.isUserInteractionEnabled = true
        kendy2.isUserInteractionEnabled = true
        kendy3.isUserInteractionEnabled = true
        kendy4.isUserInteractionEnabled = true
        kendy5.isUserInteractionEnabled = true
        kendy6.isUserInteractionEnabled = true
        kendy7.isUserInteractionEnabled = true
        kendy8.isUserInteractionEnabled = true
        kendy9.isUserInteractionEnabled = true
        kendy10.isUserInteractionEnabled = true
        kendy11.isUserInteractionEnabled = true
        kendy12.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        let recognizer12 = UITapGestureRecognizer(target: self, action: #selector(tangDiem))
        
        kendy1.addGestureRecognizer(recognizer1)
        kendy2.addGestureRecognizer(recognizer2)
        kendy3.addGestureRecognizer(recognizer3)
        kendy4.addGestureRecognizer(recognizer4)
        kendy5.addGestureRecognizer(recognizer5)
        kendy6.addGestureRecognizer(recognizer6)
        kendy7.addGestureRecognizer(recognizer7)
        kendy8.addGestureRecognizer(recognizer8)
        kendy9.addGestureRecognizer(recognizer9)
        kendy10.addGestureRecognizer(recognizer10)
        kendy11.addGestureRecognizer(recognizer11)
        kendy12.addGestureRecognizer(recognizer12)
        
        kendyArray = [kendy1, kendy2, kendy3, kendy4, kendy5, kendy6, kendy7, kendy8, kendy9, kendy10, kendy11, kendy12]
        
        counter = 10
        timeLable.text = String(counter)
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(demNguoc), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(anKendy), userInfo: nil, repeats: true)
        anKendy()
    }
    
    @objc func anKendy() {
        for kendy in kendyArray {
            kendy.isHidden = true
        }
        
        if score > hightscore {
            hightscore = score
            hightscoreLable.text = "HightScore: \(hightscore)"
            UserDefaults.standard.set(hightscore, forKey: "hightscore")
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(kendyArray.count)))
        kendyArray[randomIndex].isHidden = false
    }

    @objc func tangDiem(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            score += 1
            scoreLable.text = "Điểm: \(score)"
        }
    }
    
    @objc func demNguoc() {
        counter -= 1
        timeLable.text = String(counter)
        
        if counter == 0 {
            time.invalidate()
            hideTimer.invalidate()
            
            let alert = UIAlertController(title: "Hết giờ", message: "Bạn có muốn chơi lại không?", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            let replayButton = UIAlertAction(title: "Chơi lại", style: .default) { _ in
                self.score = 0
                self.scoreLable.text = "Điểm: \(self.score)"
                self.counter = 10
                self.timeLable.text = String(self.counter)
                
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.demNguoc), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.anKendy), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            present(alert, animated: true)
        }
    }
}
