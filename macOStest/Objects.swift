//
//  Objects.swift
//  macOStest
//
//  Created by Danny Toomey on 12/15/19.
//  Copyright © 2019 Danny Toomey. All rights reserved.
//

import SpriteKit

class Background{
    
    var background = SKNode()
    var move = SKAction()
    var reset = SKAction()
    var moveForever = SKAction()
    var roadTexture = SKTexture()
    var screenSize = CGRect()
    var scaledSize = CGSize()
    var sprite = SKSpriteNode()
    
    init(){
        roadTexture = SKTexture(imageNamed: "road")
        screenSize = NSScreen.main!.frame
        move = SKAction.moveBy(x: 0,
                               y: -screenSize.size.height,
                               duration: TimeInterval(10000/roadTexture.size().height))
        reset = SKAction.moveBy(x: 0,
                                y: screenSize.size.height,
                                duration: 0.0)
        moveForever = SKAction.repeatForever(SKAction.sequence([move,reset]))
        
        for i in Int(-screenSize.size.height) ... Int(screenSize.size.height) {
            let i = CGFloat(i)
            sprite = SKSpriteNode(texture: roadTexture)
            sprite.name = "\(i)"
            sprite.setScale(0.18)
            sprite.zPosition = 0
            sprite.position = CGPoint(x: 0,
                                      y: i * sprite.size.height)
            sprite.run(moveForever)
            background.addChild(sprite)
            scaledSize = sprite.size
            
        }
        
    }
    
    func moveBackground()->SKNode{
        for i in Int(-screenSize.size.height) ... Int(screenSize.size.height) {
            let i = CGFloat(i)
            sprite = SKSpriteNode(texture: roadTexture)
            sprite.name = "\(i)"
            sprite.setScale(0.18)
            sprite.zPosition = 0
            sprite.position = CGPoint(x: 0,
                                      y: i * sprite.size.height)
            sprite.run(moveForever)
            background.addChild(sprite)
            scaledSize = sprite.size
            
        }
        //print("background height: \(scaledSize.height)")
        //print("background width: \(scaledSize.width)")
    
        return background

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

class MotoMan:SKSpriteNode{
    init(){
        let texture = SKTexture(imageNamed: "motorcycle")
        super.init(texture: texture, color: NSColor.clear, size: texture.size())
        
        self.setScale(0.60)
        self.position = CGPoint(x: 0,
                                y: 0)
        self.zPosition = 0.9
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 3.0)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Distractor{
    var numDistractor = 4-1
    @objc var distractorArray=[SKSpriteNode]()
    var distTexture=SKTexture()
    var distractorNode=SKNode()
    var screenSize=CGRect()
    
    init(){
        let background = Background.init()
        let backRect = background.scaledSize
        let backHeight = backRect.height
        let backWidth = backRect.width / 3
        screenSize = background.screenSize
        
        let posXPosition = backWidth+2
        let negXPosition = -backWidth+10
        let posYPosition = backHeight
        let negYPosition = -backHeight
        
        let distractorLoc=[[posXPosition,posYPosition],
                  [posXPosition,negYPosition],
                  [negXPosition,posYPosition],
                  [negXPosition,negYPosition]]
        
        distTexture = SKTexture(imageNamed: "car")
        
        for dist in 0...numDistractor{
            let sprite = SKSpriteNode(texture: distTexture)
            distractorArray.append(sprite)
            let test = distractorLoc[dist]
            let testX = test.first
            let testY = test.last
            distractorArray[dist].position.x = testX!
            distractorArray[dist].position.y = testY!
            distractorArray[dist].setScale(1.0)
            distractorArray[dist].zPosition = 0.8
            distractorArray[dist].physicsBody = SKPhysicsBody(circleOfRadius: distractorArray[dist].size.height / 3.0)
            
            
        }
    }
    
    func setDistractors()->SKNode{
        for dist in 0...numDistractor{
            distractorNode.addChild(distractorArray[dist])
        }
        return distractorNode
    }
    
    @objc func setDistractorsForTrial()->SKNode{
        for dist in 0...numDistractor{
            let sprite = distractorArray[dist]
            let moveByNumPix = screenSize.height
            let move = SKAction.moveBy(x: 0,
                                       y: CGFloat(-moveByNumPix),
                                       duration: expValues.isi/2)
            let reset = SKAction.moveBy(x: 0,
                                        y: CGFloat(2*moveByNumPix),
                                        duration: TimeInterval(0))
            let respTime = SKAction.wait(forDuration: expValues.timeToResp)
            
            let sequence = SKAction.sequence([respTime,move,reset,move])
            sprite.run(sequence)
 
            distractorNode.addChild(sprite)
            
        }
        return distractorNode
        
    }
    
}


class Lasso{
    var lassoNode=SKNode()
    var lassoPixel=SKTexture()
    var backgroundPixel=SKTexture()
    var spriteArray=[SKSpriteNode]()
    var shadowArray=[SKSpriteNode]()
    var circleArray=[SKSpriteNode]()
    var circleShadArray=[SKSpriteNode]()
    var numPixels=180
    let lassoRadius=Double(15)
    
    init(){
        lassoPixel = SKTexture(imageNamed: "pixel")
        backgroundPixel = SKTexture(imageNamed: "pixelBcg")
        
        for pixel in 0...numPixels{
            let sprite = SKSpriteNode(texture: lassoPixel)
            let shadow = SKSpriteNode(texture: backgroundPixel)
            sprite.zPosition = 0.9
            shadow.zPosition = 0.85
            let scale = CGFloat(0.2)
            sprite.setScale(scale)
            shadow.setScale(scale+0.1)
            let x = (pow(Double(pixel),2.0)
                    * 0.001)
                    + 15
            let y = (pow(Double(pixel),2.6)
                    * 0.0001)
                    + 30
            sprite.position = CGPoint(x: x, y: y)
            shadow.position = CGPoint(x: x+5, y: y-10)
            spriteArray.append(sprite)
            shadowArray.append(shadow)
            
        }
        
        let lastSprite = spriteArray.last
        
        for pixel in 0...numPixels{
            let sprite = SKSpriteNode(texture: lassoPixel)
            let shadow = SKSpriteNode(texture: backgroundPixel)
            sprite.zPosition = 0.9
            shadow.zPosition = 0.85
            let scale = CGFloat(0.2)
            sprite.setScale(scale)
            shadow.setScale(scale+0.1)
            let r = lassoRadius
            let x = (2*r * cos(Double(pixel))) +
                    Double((lastSprite?.position.x)!) +
                    28
            let y = (r * sin(Double(pixel))) +
                    Double((lastSprite?.position.y)!)
                
            sprite.position = CGPoint(x: x, y: y)
            shadow.position = CGPoint(x: x+5, y: y-10)
            circleArray.append(sprite)
            circleShadArray.append(shadow)
            
        }
    }
    
    func setLasso()->SKNode{
        for pixel in 0...numPixels{
            let tail = spriteArray[pixel]
            let tailShadow = shadowArray[pixel]
            
            lassoNode.addChild(tail)
            lassoNode.addChild(tailShadow)
            
            let loop = circleArray[pixel]
            let loopShadow = circleShadArray[pixel]
            
            lassoNode.addChild(loop)
            lassoNode.addChild(loopShadow)
            
        }
        return lassoNode
    }
    
    func setLasso2()->SKNode{
        var initialLoc:SKSpriteNode?
        var moveToLoc:SKSpriteNode?
        
        for pixel in 0...numPixels{
            if pixel < numPixels{
                initialLoc = circleArray[pixel]
                moveToLoc = circleArray[pixel+1]
        
            } else {
                for pixel in 0...numPixels{
                    initialLoc = circleArray[pixel]
                    moveToLoc = circleArray.first
                
                }
            }
            let changeX = Double((moveToLoc?.position.x)!)-Double((initialLoc?.position.x)!)
            let changeY = Double((moveToLoc?.position.y)!)-Double((initialLoc?.position.y)!)
            
            let move = SKAction.moveBy(x: CGFloat(changeX),
                                       y: CGFloat(changeY),
                                       duration: TimeInterval(1.0))
            let repeatTwirl = SKAction.repeatForever(move)
            
            let tail = spriteArray[pixel]
            let tailShadow = shadowArray[pixel]
            tail.run(repeatTwirl)
            
            lassoNode.addChild(tail)
            lassoNode.addChild(tailShadow)
            
            let loop = circleArray[pixel]
            let loopShadow = circleShadArray[pixel]
            
            lassoNode.addChild(loop)
            lassoNode.addChild(loopShadow)
            
        }
        return lassoNode
    }
    
    func twirlLasso()->SKNode{
        let moveNode = SKNode()
        for tailPixel in 0...numPixels{
            var pointArray = [CGPoint()]
            var sequence = [SKAction()]
            let testSprite = spriteArray[tailPixel].copy() as! SKSpriteNode
            
            for loopPixel in 0...numPixels{
                
                let r = lassoRadius/Double((numPixels+1-tailPixel))
                let x = (2*r * cos(Double(loopPixel))) +
                        Double((spriteArray[tailPixel].position.x+28))
                let y = (r * sin(Double(loopPixel))) +
                    Double((spriteArray[tailPixel].position.y))
                
                pointArray.append(CGPoint(x:x,y:y))
                //moveNode.addChild(testSprite)
            }
        
            for loopPixel in 0...numPixels{
                if loopPixel<numPixels{
                    let move = SKAction.move(to: pointArray[loopPixel+1],
                                             duration: TimeInterval(1.0)/Double(numPixels))
                    sequence.append(move)
                    
                    
                } else {
                    let move = SKAction.move(to: pointArray.first!,
                                             duration: TimeInterval(1.0)/Double(numPixels))
                    sequence.append(move)
                    
                    
                }
                
            }
            testSprite.run(SKAction.repeatForever(SKAction.sequence(sequence)))
            moveNode.addChild(testSprite)
            
        }
        
        lassoNode.addChild(moveNode)
        
        return lassoNode
        
    }
    
    func moveLasso1()->SKNode{
        for pixel in 0...numPixels{
            let move = SKAction.moveBy(x: -CGFloat((pow(Double(pixel),1.8)
                                        * 0.0115)
                                        + 0),
                                       y: CGFloat((pow(Double(pixel),1.8)
                                        * 0.002)
                                        + 0),
                                       duration: TimeInterval(0.5))
            let movedPixels = moveLassoPixels(move: move, pixel: pixel, rotate: true)
            lassoNode.addChild(movedPixels)
            
        }
        return lassoNode
    
    }
    
    func moveLasso2()->SKNode{
        for pixel in 0...numPixels{
            let move = SKAction.moveBy(x: CGFloat((pow(Double(pixel),2.0)*0.01)+0),
                                       y: CGFloat((pow(Double(pixel),2.0)*0.01)+0),
                                       duration: TimeInterval(0.5))
            let movedPixels = moveLassoPixels(move: move, pixel: pixel, rotate: true)
            lassoNode.addChild(movedPixels)
            
        }
        return lassoNode
        
    }
    
    func moveLasso3()->SKNode{
        for pixel in 0...numPixels{
            let move = SKAction.moveBy(x: CGFloat((pow(Double(pixel),2.0)*0.01)+0),
                                       y: CGFloat((pow(Double(pixel),2.0)*0.01)+0),
                                       duration: TimeInterval(0.5))
            let movedPixels = moveLassoPixels(move: move, pixel: pixel, rotate: true)
            lassoNode.addChild(movedPixels)
            
        }
        return lassoNode
        
        
    }
    
    var moveToPixel:SKSpriteNode?
    var rotateLoop=SKAction()
    func moveLassoPixels(move: SKAction, pixel: Int, rotate: Bool)->SKNode{
        
        let moveNode = SKNode()
        
        let tail = spriteArray[pixel]
        let tailShadow = shadowArray[pixel]
        tail.name = "tail.\(pixel)"
        tail.run(move)
        tailShadow.run(move)
        moveNode.addChild(tail)
        moveNode.addChild(tailShadow)
        
        if pixel == numPixels{
            for loopPixel in 0...numPixels{
                let loop = circleArray[loopPixel]
                let loopShadow = circleShadArray[loopPixel]
                loop.run(move)
                loopShadow.run(move)
                
                if rotate{
                    let rotateByPix = 10
                    let r = Double(15)
                    
                    for pix in 1...rotateByPix{
                        let x1 = (2*r * cos(Double(pixel)))
                        let y1 = (r * sin(Double(pixel)))
                        let x2 = (2*r * cos(Double(pixel)))
                        let y2 = (r * sin(Double(pixel)))
                        
                        
                        
                    }
                    
                    /*var rotateToPixel=SKSpriteNode()
                    
                    if loopPixel<=int{
                        rotateToPixel=circleArray[numPixels-int+loopPixel]
                    } else {
                        rotateToPixel=circleArray[loopPixel-int]
                    }
                    rotateLoop = SKAction.move(to: rotateToPixel.position,
                                             duration: TimeInterval(0.5))
                      */
                    /*
                    let rotatePixel = circleArray[loopPixel]
                    let int=10
                    if loopPixel<int{
                        moveToPixel = circleArray[numPixels-int+loopPixel]
                    } else {
                        moveToPixel = circleArray[loopPixel-int]
                    }
                    let rotateBy1 = (moveToPixel?.position)!
                    let rotateBy2 = rotatePixel.position
                    let rotateByX = rotateBy1.x - rotateBy2.x
                    let rotateByY = rotateBy1.y - rotateBy2.y
                    rotateLoop = SKAction.moveBy(x: rotateByX,
                                                 y: rotateByY,
                                                 duration: TimeInterval(0.5))
                    */
                    
                    loop.run(rotateLoop)
                                
                }
                
        
                moveNode.addChild(loop)
                moveNode.addChild(loopShadow)
                
            }
        }
        return moveNode
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


