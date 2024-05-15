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
            answer()
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
    
    func answer() {
        
        var translationTransform: CGAffineTransform
        //画面の横幅を取得
        let screenWidth = UIScreen.main.bounds.width
        //画面の高さを取得して0.2倍
        let y = UIScreen.main.bounds.height * 0.2
        
        if self.quizCarad.style == .right {
            // 右へ移動させるアフィン変換
            translationTransform = CGAffineTransform(translationX: screenWidth, y: y)
            self.quizManager.answerQuiz(answer: true)
        } else {
            // 左へ移動させるアフィン変換
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: y)
            self.quizManager.answerQuiz(answer: false)
        }
        
        // 教科書 P229
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1,
            options: [.curveLinear],
            animations: {
                self.quizCarad.transform = translationTransform
            },
            completion: { finished in
                if finished {
                    self.showNextQuiz()
                }
            }
        )
    }
    
    func showNextQuiz() {
        self.quizManager.nextQuiz()
        
        self.quizCarad.transform = .identity
        self.quizCarad.style = .initial
        self.loadQuiz()
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
