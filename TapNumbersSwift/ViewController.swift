//
//  ViewController.swift
//  TapNumbersSwift
//
//  Created by Ken Tominaga on 6/28/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var combinationLabel: UILabel
    var combination: Int[] = [0, 0, 0, 0]
    // var combination: Int[4] = Int[4]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.newGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // go next problem
    func newGame() {
        combination = self.produceCombination()
        combinationLabel.attributedText = self.makeStringFromArray(combination)
    }
    
    // show combination without [], and highlight the target number
    func makeStringFromArray(array: Array<Int>) -> NSAttributedString {
        var labelText: NSMutableAttributedString = NSMutableAttributedString()
        
        for var i: Int = 0; i < array.count; i++ {
            
            let attributedString = NSMutableAttributedString(string: "\(array[i])")
            
            if i == 0 {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 1))
            }
            
            labelText.appendAttributedString(attributedString)
        }
        
        return labelText
    }
    
    func produceCombination() -> Int[] {
        
        combination = [0, 0, 0, 0]
        
        for var i: Int = 0; i < 4; i++ {
            combination[i] = Int(arc4random_uniform(UInt32(4))) + 1
        }
        
        return combination;
    }
    
    @IBAction func buttonPressed(button: UIButton) {
        // check number
        if combination[0] == button.tag {
            combination.removeAtIndex(0)
            combinationLabel.attributedText = self.makeStringFromArray(combination)
        }
        
        // if combination becomes empty, go next game
        if combination.count == 0 {
            self.newGame()
        }
    }
}

