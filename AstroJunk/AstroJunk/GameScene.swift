//
//  GameScene.swift
//  AstroJunk
//
//  Created by Adriana González Martínez on 7/15/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene {
    
    var ship : Spaceship!
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    let spaceshipMovePointsPerSec: CGFloat = 2.5
    var velocity = CGPoint.zero
    var shipMoves = false
    var shipGoesRight = false
    
    override func didMove(to view: SKView) {
        createBackground()
        createSpaceship()
        createMeteorsAndDebris()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime

        if(shipMoves){ //It moves when touches begin
            if(shipGoesRight){
                move(sprite: ship, velocity: CGPoint(x: spaceshipMovePointsPerSec, y: 0))
            }else{
                move(sprite: ship, velocity: CGPoint(x: -spaceshipMovePointsPerSec, y: 0))
            }
        }
    }
    
    func createBackground(){
        let background = SKSpriteNode(imageNamed: "background")
        background.zPosition = -1
        background.size = UIScreen.main.bounds.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
    }
    
    func createSpaceship(){
        ship = Spaceship()
        ship.position.x = (self.scene?.frame.size.width)!/2
        ship.position.y = ship.frame.size.height
        addChild(ship)
    }
    
    func createMeteorsAndDebris(){

        let waitAction = SKAction.wait(forDuration: 2)
        let createMeteors = SKAction.run {
            if Bool.random(){
                let item = Meteor()
                item.position.x = CGFloat.random(in: 0..<(self.scene?.frame.size.width)!)
                item.position.y = (self.scene?.frame.size.height)!
                self.addChild(item)
                item.startMoving()
            }else{
                let item = Debris()
                item.position.x = CGFloat.random(in: 0..<(self.scene?.frame.size.width)!)
                item.position.y = (self.scene?.frame.size.height)!
                self.addChild(item)
                item.startMoving()
            }
            
        }
        let creationSequence = SKAction.sequence([waitAction, createMeteors])
        let repeatCreation = SKAction.repeatForever(creationSequence)
        self.run(repeatCreation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
           
            if location.x <= (self.scene?.frame.size.width)!/2{
                //spaceship goes left
                shipMoves = true
                shipGoesRight = false
                
            }else{
                //spaceship goes right
                shipMoves = true
                shipGoesRight = true

            }
        }
        
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = CGPoint(x: velocity.x, y: velocity.y)
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
}


