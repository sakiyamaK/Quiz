//
//  QuizCard.swift
//  Quiz
//
//  Created by sakiyamaK on 2024/05/09.
//

import UIKit

class QuizCard: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    enum QuizStyle {
        case initial, right, wrong
    }
    
    var style: QuizStyle = .initial {
        didSet {
            setQuizStyle(style: style)
        }
    }
    
    private func setQuizStyle(style: QuizStyle) {
        switch style {
        case .initial:
            self.backgroundColor = UIColor.lightGray
            self.label.text = "未回答"
        case .right:
            self.backgroundColor = UIColor.systemGreen
            self.label.text = "正解"
        case .wrong:
            self.backgroundColor = UIColor.systemRed
            self.label.text = "不正解"
        }
    }
}
