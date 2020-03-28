//
//  GameScene.swift
//  macOSdefaults
//
//  Created by Danny Toomey on 11/2/19.
//  Copyright © 2019 Danny Toomey. All rights reserved.
//

// adam gazzaley neuroracer

import SpriteKit
import CoreData

class GameScene:SKScene,SKPhysicsContactDelegate{
    //participant variables
    let participantID = 1
    
    //boolean variables
    var instructionsShown=Bool()
    var sceneShown = Bool()
    var pressed = Bool()
    var fKeyUp = Bool()
    var jKeyUp = Bool()
    
    //numeric variables
    var rt = Double()
    var useUpdate=Int()
    var numUpdates = 0
    var presses = 0.0
    var trial=0
    
    //time variables
    var info = mach_timebase_info()
    var timeStart=UInt64(0)
    var updatedTime = TimeInterval()
    var timeArray = [TimeInterval()]
    
    //string variables
    var keyPressed = String()
    
    //node variables are created before the functions that write to them
    
    override func sceneDidLoad() {
        createInstructionLabel()
        timeStart=guardTime()
        
    }
    
    var instructionLabel:SKLabelNode!
    func createInstructionLabel(){
        self.instructionLabel = self.childNode(withName: "//label") as? SKLabelNode
        if let instructionLabel = self.instructionLabel{
            instructionLabel.alpha = 0.0
            instructionLabel.run(SKAction.fadeIn(withDuration: 0))
        }
        self.backgroundColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        instructionLabel?.text = """
        these are instructions
        this is a second line
        this is a third line
        """
        instructionLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        instructionLabel?.numberOfLines = 0
        
    }
    
    var trialElapsed=TimeInterval()
    override func didMove(to view: SKView){
        var start=TimeInterval(0)
        var data = Data.init()
        
        if instructionsShown==true && sceneShown != true{
            self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
            self.physicsWorld.contactDelegate = self
            
            getBackground()
            getMotoMan()
            getLasso()
            twirlLasso()
            
            getDistractors()
            
            sceneShown=true
            
            useUpdate = numUpdates
            
        } else if sceneShown == true {
            
            start=timeArray[useUpdate]
            trialElapsed=Double(updatedTime-start)
            //print("trialElapsed:\(trialElapsed)")
            if trial<expValues.numTrials{
                if Double(trialElapsed)>Double(expValues.isi+expValues.timeToResp){
                    trial=trial+1
                    useUpdate=numUpdates
                    setDistractorsForTrial()
                    data.addTrialData(pid: participantID,
                                      trial: trial,
                                      rt: rt,
                                      keyPress: keyPressed)
                    print(data)
                    rt=0
                    keyPressed="nil"
                    
                }
                
            }
            
        }
        
    }
    
    func guardTime()->(UInt64){
        guard mach_timebase_info(&info) == KERN_SUCCESS else { return 0 }
        let start = mach_absolute_time()
        
        return (start)
        
    }
    
    func getBackground(){
        let bcg = Background.init()
        let moveBcg = bcg.moveBackground()
        self.addChild(moveBcg)
    }
    
    var motoMan:SKSpriteNode!
    func getMotoMan(){
        motoMan = MotoMan.init()
        self.addChild(motoMan)
    }
    
    var distNode=SKNode()
    func getDistractors(){
        let distractors = Distractor.init()
        distNode = distractors.setDistractors()
        distNode.name = "distNode"
        self.addChild(distNode)
        
    }
    
    func setDistractorsForTrial(){
        if let child = self.childNode(withName: "distNode"){
            child.removeFromParent()
        }
        let distractors = Distractor.init()
        distNode = distractors.setDistractorsForTrial()
        distNode.name = "distNode"
        self.addChild(distNode)
        
    }
    
    func getLasso(){
        let lasso = Lasso.init()
        let setLasso = lasso.setLasso()
        setLasso.name = "setLasso"
        self.addChild(setLasso)
        
    }
    
    func twirlLasso(){
        if let child = self.childNode(withName: "setLasso") {
            child.removeFromParent()
        }
        let lasso = Lasso.init()
        let twirlLasso = lasso.twirlLasso()
        twirlLasso.name = "twirlLasso"
        self.addChild(twirlLasso)
    }
    
    override func keyDown(with event: NSEvent){
        switch event.keyCode{
        case keyCodes.space:
            if self.instructionLabel != nil {
                instructionsShown=true
                //setBlock=true
                //updateCalled=true
                presses = presses+1
                let thisPress = presses/2
                if thisPress.rounded() == thisPress {
                    instructionLabel?.text = """
                    pressed
                    space
                    """
                }else{
                    instructionLabel?.text = """
                    pressed
                    space
                    again
                    """
                }
                let screenSize:CGRect = NSScreen.main!.frame
                instructionLabel.position = CGPoint(x: -screenSize.width/3.5,
                                                    y: screenSize.height/5)
                instructionLabel.zPosition = 1
                if sceneShown == true{
                    resetScene()
                }
            }
            
        case keyCodes.f:
            if sceneShown == true{
                if let child = self.childNode(withName: "setLasso") {
                    child.removeFromParent()
                }
                if self.childNode(withName: "moveLasso") == nil{
                    let lasso = Lasso.init()
                    let moveLasso = lasso.moveLasso1()
                    moveLasso.name = "moveLasso"
                    self.addChild(moveLasso)
                    
                }
                keyPressed="\(event.characters!)"
                rt = trialElapsed
                pressed=true
            }
            
        case keyCodes.j:
            if sceneShown == true{
                if let child = self.childNode(withName: "setLasso") {
                    child.removeFromParent()
                }
                if self.childNode(withName: "moveLasso2") == nil{
                    let lasso = Lasso.init()
                    let moveLasso = lasso.moveLasso2()
                    moveLasso.name = "moveLasso2"
                    self.addChild(moveLasso)
                    
                }
                keyPressed="\(event.characters!)"
                
                pressed=true
            }
            
        default:
            self.instructionLabel?.text = """
            keyDown: \(event.characters!)
            keyCode: \(event.keyCode)
            rt: \(Double(round(100*rt)/100))
            trial: \(trial)
            """
            instructionLabel.fontSize = 25
            
            keyPressed="\(event.characters!)"
            pressed=true
        }
    
    }
    
    func resetScene (){
        if let child = self.childNode(withName: "moveLasso") {
            child.removeFromParent()
        }
        if let child = self.childNode(withName: "moveLasso2") {
            child.removeFromParent()
        }
        if self.childNode(withName: "setLasso") == nil{
            let lasso = Lasso.init()
            let setLasso = lasso.setLasso()
            setLasso.name = "setLasso"
            self.addChild(setLasso)
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval){
        numUpdates = numUpdates+1
        let current = mach_absolute_time()
        let time = current-timeStart
        let nanos = time * UInt64(info.numer) / UInt64(info.denom)
        updatedTime = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
        timeArray.append(updatedTime)
        self.didMove(to: (self.view)!)
        
    }
    
}
