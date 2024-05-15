//
//  ViewController.swift
//  Quiz
//
//  Created by sakiyamaK on 2024/05/09.
//

import UIKit

class ViewController: UIViewController {

    private var quizCarad: QuizCard = UINib(nibName: "QuizCard", bundle: nil).instantiate(withOwner: nil).first as! QuizCard

    let quizManager = QuizManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        
        self.quizCarad.style = QuizCard.QuizStyle.initial

        loadQuiz()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draqQuiz(_:)))
        self.quizCarad.addGestureRecognizer(panGesture)
    }
    
    func loadQuiz() {
        self.quizCarad.label.text = quizManager.currentQuiz.text
        self.quizCarad.imageView.image = UIImage(named: quizManager.currentQuiz.imageName)
    }
    
    @objc func draqQuiz(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformQuizcard(gesture: sender)
        case .ended:
            print("おわり")
            self.quizCarad.transform = .identity
            self.quizCarad.style = .initial
        default:
            print("それ以外")
        }
    }

    
    func transformQuizcard(gesture: UIPanGestureRecognizer) {
        let point = gesture.translation(in: quizCarad)
        
        //座標移動
        let moveTransform = CGAffineTransform(translationX: point.x, y: point.y)

        // 回転
        let percent = point.x/UIScreen.main.bounds.width/2
        let angle = CGFloat.pi/3 * percent
        let rotateTransform = CGAffineTransform(rotationAngle: angle)
//
//        // 座標移動と回転の合体
        let transform = moveTransform.concatenating(rotateTransform)
        
        // Viewに登録
        self.quizCarad.transform = transform
        
        if point.x > 0 {
            self.quizCarad.style = .right
        } else {
            self.quizCarad.style = .wrong
        }
    }

}


private extension ViewController {
    func setupLayout() {
        self.view.addSubview(quizCarad)
        quizCarad.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizCarad.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            quizCarad.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            quizCarad.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8, constant: 0)
        ])
    }
}
