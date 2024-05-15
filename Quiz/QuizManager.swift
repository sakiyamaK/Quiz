//
//  QuizManager.swift
//  Quiz
//
//  Created by sakiyamaK on 2024/05/15.
//

import Foundation

class QuizManager {
    var quizzes: [Quiz]
    var currentIndex: Int
    var score: Int
    
    enum Status {
        case inAnswer, done
    }
    
    var status: Status
    
    init() {
        quizzes = [
            Quiz(text: "人間を超でっかい猫だと思っている", correctAnswer: true, imageName: "cat"),
//            Quiz(text: "犬は食べ物のおいしさを味よりも匂いで判断している？", correctAnswer: true, imageName: "dog"),
//            Quiz(text: "トラのしましま模様は皮膚まで繋がっていない？", correctAnswer: false, imageName: "tiger"),
//            Quiz(text: "パンダの好物は笹である", correctAnswer: false, imageName: "panda")
        ]
        
        currentIndex = 0
        score = 0
        status = .inAnswer
    }
    
    var currentQuiz: Quiz {
        get {
            return self.quizzes[currentIndex]
        }
    }
    // 上の記述はこうも書けるよ1
    // 本来は get {} set {}がひとつのセットだがget {}だけなら省略できる
    var currentQuiz2: Quiz {
        return self.quizzes[currentIndex]
    }

    // 上の記述はこうも書けるよ2
    // 1行しかない記述だとreturnも省略できる
    var currentQuiz3: Quiz {
        self.quizzes[currentIndex]
    }
    
    func answerQuiz(answer: Bool) {
        if self.currentQuiz.correctAnswer == answer {
            score += 1
        }
    }
    
    // 上の記述はこうも書けるよ
    // swiftには条件チェックをするためのguard文がある
    func answerQuiz2(answer: Bool) {
        // この関数の処理をすべきかどうか最初にチェック
        guard self.currentQuiz.correctAnswer != answer else {
            // チェックを通らないようなら終わる
            return
        }
        
        // このscoreを更新する処理がメインであることが分かりやすい
        score += 1
    }
    
    func nextQuiz() {
        if currentIndex < quizzes.count - 1 {
            currentIndex += 1
        } else {
            status = .done
        }
    }

}
