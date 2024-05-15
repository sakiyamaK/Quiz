//
//  ResultViewController.swift
//  Quiz
//
//  Created by sakiyamaK on 2024/05/15.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!        
    @IBOutlet weak var textView: UITextView!
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.text = "あなたのスコアは\(score)です！！"
        
        var text: String = ""
        switch score {
        case 0...2:
            text = "素人かよ！！！\n\nもっと頑張れよ！！"
        case 3,4:
            text = "ええやん！\n\nええやん！\n\nええやん！"
        case 5:
            text = "全問正解やん！！！\n\n神ぃぃぃっぃい！！"
        default:
            break
        }
        
        textView.text = text
    }
    
    
    @IBAction func tapButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
