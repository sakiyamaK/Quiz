//
//  Quiz.swift
//  Quiz
//
//  Created by sakiyamaK on 2024/05/15.
//

import UIKit

class Quiz {
    let text: String
    let correctAnswer: Bool
    let imageName: String
    
    init(text: String, correctAnswer: Bool, imageName: String) {
        self.text = text
        self.correctAnswer = correctAnswer
        self.imageName = imageName
    }
}
