//
//  GameScene.swift
//  Memorize Multiplication Tables
//
//  Created by Greg Willis on 3/6/16.
//  Copyright (c) 2016 Willis Programming. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    
    var answerButton: UIButton?
    var touchLocation: CGPoint!

    var numberOneArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var numberTwoArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    var randomNumberOne: Int!
    var randomNumberTwo: Int!
    var answer: Int!

    override func didMoveToView(view: SKView) {
        if let controller = GameViewController.controller {
            controller.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        backgroundColor = Colors.darkRedColor
        pickRandomNumber()
        spawnNumber()
        spawnTimesOperator()
        answerButton = spawnAnswerButton()
    }
   
    
}

// MARK: - Spawn Functions
extension GameScene {
    
    func spawnNumber() {
        createNumber(CGPoint(x: CGRectGetWidth(self.frame) * 0.6, y: CGRectGetHeight(self.frame) * 0.65), randomNumber: randomNumberOne)
        createNumber(CGPoint(x: CGRectGetWidth(self.frame) * 0.6, y: CGRectGetHeight(self.frame) * 0.3), randomNumber: randomNumberTwo)
        
    }
    
    func spawnTimesOperator() -> SKLabelNode {
        let timesOperator = SKLabelNode(fontNamed: "Avenir")
        timesOperator.fontSize = 150
        timesOperator.fontColor = Colors.offWhiteColor
        timesOperator.position = CGPoint(x: CGRectGetWidth(self.frame) * 0.22, y: CGRectGetHeight(self.frame) * 0.3)
        timesOperator.text = "X"
        addChild(timesOperator)
        
        return timesOperator
    }
    
    func spawnAnswerButton() -> UIButton {
        let answerButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 70))
        answerButton.center = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame) * 0.85)
        answerButton.backgroundColor = Colors.offBlackColor
        answerButton.layer.cornerRadius = 10
        answerButton.layer.borderWidth = 2.0
        answerButton.layer.borderColor = Colors.offWhiteColor.CGColor
        answerButton.titleLabel?.font = UIFont(name: "Avenir", size: 50)
        answerButton.setTitle("Answer", forState: UIControlState.Normal)
        answerButton.setTitleColor(Colors.offWhiteColor, forState: UIControlState.Normal)
        answerButton.addTarget(self, action: Selector("goToAnswer"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(answerButton)
        return answerButton
    }
}

// MARK: - Helper Functions
extension GameScene {
    
    func createNumber(position: CGPoint, randomNumber: Int) -> SKLabelNode {
        let number = SKLabelNode(fontNamed: "Avenir")
        number.fontSize = 225
        number.fontColor = Colors.offWhiteColor
        
        number.position = position
        number.text = "\(randomNumber)"
        
        addChild(number)
        
        return number
    }
    
    func goToAnswer() {
        if let answerButton = answerButton {
            answerButton.removeFromSuperview()
        } else {
            assert(answerButton != nil, "Answer Button is nil")
        }
        
        if let scene = AnswerScene(fileNamed: "AnswerScene") {
            let skView = self.view! as SKView
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
            scene.answerNumber = answer
            skView.presentScene(scene)
        }
    }
    
    func pickRandomNumber() -> Int {
        let index1 = Int(arc4random_uniform(11))
        randomNumberOne = numberOneArray[index1]
        let index2 = Int(arc4random_uniform(11))
        randomNumberTwo = numberTwoArray[index2]
        answer = randomNumberOne * randomNumberTwo
        return answer

    }
}
