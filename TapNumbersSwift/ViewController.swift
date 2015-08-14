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
        combinationLabel.text = makeSimpleStringFromArray(combination)
//        combinationLabel.attributedText = makeHighlightedStringFromArray(combination)
    }
    
    // show combination and highlight the target(first) number
    private func makeHighlightedStringFromArray(array: [Int]) -> NSMutableAttributedString {
        if array.isEmpty {
            return NSMutableAttributedString(string: "")
        }
        
        let attributedString = NSMutableAttributedString(string: "".join(array.map{"\($0)"}))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 1))
        return attributedString
    }
    
    // concatenate: [Int] -> [String] then join.
    // [1, 2, 4, 3] -> ["1", "2", "4", "3"] -> "1243"
    private func makeSimpleStringFromArray(array: [Int]) -> String {
        return "".join(array.map{"\($0)"})
//        var simpleString = ""
//        for number in array {
//            simpleString += "\(number)"
//        }
//        return simpleString
    }
    
    // 1 ~ 4
    private func produceCombination() -> [Int] {
        return Array(0..<4).map{_ in Int(arc4random_uniform(UInt32(4))) + 1}
//        var comb = [Int]()
//        
//        for _ in 0 ..< 4 {
//            comb.append(Int(arc4random_uniform(UInt32(4))) + 1)
//        }
//        
//        return comb
    }
    
    @IBAction private func buttonPressed(button: UIButton) {
        
        // get the text of pressed button
        if let number = Int(button.titleForState(.Normal)!) {
            if number == combination.first! {  // check number
                combination.removeAtIndex(0)
                combinationLabel.text = makeSimpleStringFromArray(combination)
//                combinationLabel.attributedText = makeHighlightedStringFromArray(combination)
            }
        }
        
        // if combination becomes empty, go next game
        if combination.isEmpty {
            newGame()
        }
    }
}

