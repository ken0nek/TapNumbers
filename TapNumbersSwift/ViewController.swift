//
//  ViewController.swift
//  TapNumbersSwift
//
//  Created by Ken Tominaga on 6/28/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var combinationLabel: UILabel!
    private var combination = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // create new game
    private func newGame() {
        combination = produceCombination()
        combinationLabel.attributedText = makeHighlightedString(array: combination)
    }
    
    // show combination and highlight the target(first) number
    private func makeHighlightedString(array: [Int]) -> NSMutableAttributedString {
        
        let attributedStrings = array.enumerated().map { (i, ele) -> NSAttributedString in
            if i == 0 {
                return NSAttributedString(string: String(ele), attributes: [NSForegroundColorAttributeName: UIColor.red])
            } else {
                return NSAttributedString(string: String(ele))
            }
        }
        
        return attributedStrings.reduce(NSMutableAttributedString(string: "")) { (sum, now) -> NSMutableAttributedString in
            sum.append(now)
            return sum
        }
    }
    
    // concatenate: [Int] -> [String] then join.
    // [1, 2, 4, 3] -> ["1", "2", "4", "3"] -> "1243"
    private func makeSimpleString(array: [Int]) -> String {
        return array.map { String($0) }.joined()
    }
    
    // 1 ~ 4
    private func produceCombination() -> [Int] {
        return (0 ..< 4).map {_ in Int(arc4random_uniform(UInt32(4))) + 1}
    }
    
    @IBAction private func buttonPressed(_ button: UIButton) {
        
        // get the text of pressed button
        if let number = Int(button.title(for: .normal)!) {
            if number == combination.first! {  // check number
                combination.remove(at: 0)
                combinationLabel.attributedText = makeHighlightedString(array: combination)
            }
        }
        
        // if combination becomes empty, go next game
        if combination.isEmpty {
            newGame()
        }
    }
}
