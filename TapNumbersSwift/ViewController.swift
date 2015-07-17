//
//  ViewController.swift
//  TapNumbersSwift
//
//  Created by Ken Tominaga on 6/28/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var combinationLabel: UILabel!
    var combination = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // go next problem
    func newGame() {
        combination = produceCombination()
//        combinationLabel.attributedText = makeHighlightedStringFromArray(combination)
        combinationLabel.text = makeSimpleStringFromArray(combination)
    }
    
    // show combination without [], and highlight the target number
    func makeHighlightedStringFromArray(array: [Int]) -> NSAttributedString {
        var labelText = NSMutableAttributedString()
        
        for i in 0 ..< array.count {
            
            let attributedString = NSMutableAttributedString(string: "\(array[i])")
            
            if i == 0 { // make target number red color
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 1))
            }
            
            labelText.appendAttributedString(attributedString)
        }
        
        return labelText
    }
    
    // concatenate: Int -> String then join.
    func makeSimpleStringFromArray(array: [Int]) -> String {
        return "".join(array.map{"\($0)"})
    }
    
    // 1 ~ 4
    func produceCombination() -> [Int] {
        
        var comb = [Int]()
        
        for _ in 0 ..< 4 {
            comb.append(Int(arc4random_uniform(4)) + 1)
        }
        
        return comb
    }
    
    @IBAction func buttonPressed(button: UIButton) {
        
        // check number
        if let number = button.titleForState(.Normal)?.toInt() {
            if number == combination.first! {
                combination.removeAtIndex(0)
                //            combinationLabel.attributedText = makeHighlightedStringFromArray(combination)
                combinationLabel.text = makeSimpleStringFromArray(combination)
            }
        }
        
        // if combination becomes empty, go next game
        if combination.count == 0 {
            newGame()
        }
    }
}

