//
//  ViewController.swift
//  Quizzler


import UIKit
import JGProgressHUD

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = true
        }else if sender.tag == 2{
            pickedAnswer = false
        }
        checkAnswer()
        
        questionNumber += 1

        nextQuestion()

    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        
        updateUI()

        if questionNumber < allQuestions.list.count{
            
            let firstQuestion = allQuestions.list[questionNumber]
        
            self.questionLabel.text = firstQuestion.question

            
        }else{
            
            let controller = UIAlertController(title: "Restart", message: "You want to restart the game", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            
        }
    }
    
    
    func checkAnswer() {

        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if pickedAnswer == correctAnswer{
            
            score += 1
            showHud(result: true)
        }else{
            
            showHud(result: false)
            print("Wrong Answer !!")
            
        }
      
    }
    
    
    func startOver() {
        
       questionNumber = 0
       score = 0
       nextQuestion()
        
    }
    
    func showHud(result: Bool){
        
        let hud = JGProgressHUD(style: .dark)
 
        if result == true{
            hud?.textLabel.text = "Correct"
            hud?.indicatorView = JGProgressHUDSuccessIndicatorView()
        }else{
            hud?.textLabel.text = "Wrong"
            hud?.indicatorView = JGProgressHUDErrorIndicatorView()
        }
        
        hud?.show(in: self.view)
        hud?.dismiss(afterDelay: 0.5)
     
    }

    
}
