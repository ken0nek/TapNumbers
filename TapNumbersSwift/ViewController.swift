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
//        combinationLabel.text = makeSimpleStringFromArray(combination)
        combinationLabel.attributedText = makeHighlightedStringFromArray(combination)
    }
    
    // show combination and highlight the target(first) number
    private func makeHighlightedStringFromArray(array: [Int]) -> NSMutableAttributedString {
        
        let attributedStrings = array.enumerate().map { (i, ele) -> NSAttributedString in
            if i == 0 {
                return NSAttributedString(string: String(ele), attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            } else {
                return NSAttributedString(string: String(ele))
            }
        }
        
        return attributedStrings.reduce(NSMutableAttributedString(string: "")) { (sum, now) -> NSMutableAttributedString in
            sum.appendAttributedString(now)
            return sum
        }
    }
    
    // concatenate: [Int] -> [String] then join.
    // [1, 2, 4, 3] -> ["1", "2", "4", "3"] -> "1243"
    private func makeSimpleStringFromArray(array: [Int]) -> String {
        return array.map { String($0) }.joinWithSeparator("")
    }
    
    // 1 ~ 4
    private func produceCombination() -> [Int] {
        return Array(0 ..< 4).map {_ in Int(arc4random_uniform(UInt32(4))) + 1}
    }
    
    @IBAction private func buttonPressed(button: UIButton) {
        
        // get the text of pressed button
        if let number = Int(button.titleForState(.Normal)!) {
            if number == combination.first! {  // check number
                combination.removeAtIndex(0)
//                combinationLabel.text = makeSimpleStringFromArray(combination)
                combinationLabel.attributedText = makeHighlightedStringFromArray(combination)
            }
        }
        
        // if combination becomes empty, go next game
        if combination.isEmpty {
            newGame()
        }
    }
}

