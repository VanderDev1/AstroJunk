//
//  Spaceship.swift
//  AstroJunk
//
//  Created by Adriana González Martínez on 7/15/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import SpriteKit

class Spaceship: SKSpriteNode {
    
    init() {
        
        let texture = SKTexture(imageNamed: "spaceship")
        let size = texture.size()
        let color = UIColor.clear
        
        super.init(texture: texture, color: color, size: size)
        
        self.name = "spaceship"
        
    }
    
    func moveLeft(){
      
    }
    
    func moveRight(){
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
        
    }
    
}
