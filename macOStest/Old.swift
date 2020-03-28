//
//  Old.swift
//  macOStest
//
//  Created by Danny Toomey on 12/23/19.
//  Copyright © 2019 Danny Toomey. All rights reserved.
//

import Foundation

//function graveyard


/*
 

 func timeTrial(){
     if timeStart==0{
         timeStart=guardTime()
         print("time set")
         //time=0
         
     } else {
         timeEnd=mach_absolute_time()
         let elapsed = timeEnd - timeStart
         let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
         time = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
         
         while time<TimeInterval(1.0){
             continue
         }

     }
     
     
 }
 
 func runBlock(){
     
     //setDistractorsForTrial()
     trialLoop: while trial<4{
         if trialSet==false{
             setDistractorsForTrial()
             trialSet=true
             //updateCalled=true
             print("trial set")
             
         }
         if timeStart==0{
             timeStart=guardTime()
             print("time set")
             //time=0
             
         } else {
             timeEnd=mach_absolute_time()
             let elapsed = timeEnd - timeStart
             let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
             time = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
             
             if time > TimeInterval(1.0){
                 trial=trial+1
                 print("trial:\(trial)")
                 trialSet=false
                 timeStart=0
             }
             
             

         }
         
     }
 }
 
 

 func runTrial(){
     
     
     
     setDistractorsForTrial()
     print("trial set")
     if timeStart==0{
         timeStart=guardTime()
         print("time set")
         //time=0
         
     } else {
         timeEnd=mach_absolute_time()
         let elapsed = timeEnd - timeStart
         let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
         time = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
         
         while time<TimeInterval(1.0){
             continue
         }

     }
     
 }
 
 
 
 
 /*
 

     /*
     if sceneShown{
         
         /*
         while trial<4{
             if trialIsSet != true{
                 (trialIsSet, trialIsDone) = setTrial()
             }
             if trialIsDone == false {
                 trialStart = DispatchTime.now().uptimeNanoseconds
                 (keyPressed,rt,trialIsDone) = timeBlockWithMach{
                     //start timed block
                     while pressed != true{
                         trialEnd = DispatchTime.now().uptimeNanoseconds
                         elapsedTime = (trialEnd - trialStart)/1000000000
                         
                         if elapsedTime == UInt64(TimeInterval(1.0)){
                             pressed=true
                         } else {
                             continue
                         }
                         
                     }
                     //end timed block
                     
                 }
             
             }
             guard let pressed = true else {
                 
                     data.addTrialData(pid: participantID, trial: trial, rt: rt, keyPress: keyPressed)
                     trial=trial+1
                     print(trial)
                     
                     pressed = false
                     
                 
                 
             }
             
             
         }
         */
         
         /*
         for t in 0...4{
             print(t)
             
             if trialIsSet != true {
                 (trialIsSet, trialIsDone) = setTrial(t: t)
                 
             }
             
             if trialIsDone == false {
                 trialStart = DispatchTime.now().uptimeNanoseconds
                 (keyPressed,rt,trialIsDone) = timeBlockWithMach{
                     
                     while pressed != true{
                         trialEnd = DispatchTime.now().uptimeNanoseconds
                         elapsedTime = (trialEnd - trialStart)/1000000000
                         
                         if elapsedTime == UInt64(TimeInterval(1.0)){
                             break
                         } else {
                             continue
                         }
                         
                     }
                     
                 }
                 
             }
             
             if trialIsDone==true{
                 data.addTrialData(pid: participantID, trial: trial, rt: rt, keyPress: keyPressed)
                 trialIsSet=false
                 //trialSet = setTrial(t: t+1)
                 
                 
             }
             
             
             
         
             
         }
         */
     }
     */
 
 
 var fired=Bool()
 var trialIsDone=Bool()
 
 func runTrial(){
     trialIsDone=false
     if sceneShown{
         
         while trial<4 {
             if fired != true{
                 (fired,(keyPressed,rt,trialIsDone)) = setTrial2()
                 print("fired:\(fired)")
                 print("keyPressed:\(keyPressed)")
                 print("trialIsDone:\(trialIsDone)")
                 
                 if trialIsDone==true{
                     trial=trial+1
                     print(trial)
                     fired=false
                     trialIsDone=false
                     
                 }
             }
         }
         
     }
     
 }
 
 func setTrial2()->(Bool,(String,TimeInterval,Bool)){
     rt = 0
     keyPressed = "nil"
     setDistractorsForTrial()
     trialStart = DispatchTime.now().uptimeNanoseconds
     pressed=false
     
     return (true, timeBlockWithMach {
         //timed block
         while pressed == false{
             trialEnd = DispatchTime.now().uptimeNanoseconds
             elapsedTime = (trialEnd - trialStart)/1000000000
             //print(elapsedTime)
             if elapsedTime == UInt64(TimeInterval(1.0)){
                 pressed=true
             } else {
                 continue
             }
             
         }
         // returns the time it took to execute this block and the key pressed
     })
 }
 
 //var trialIsSet=Bool()
 func setTrial()->(Bool,Bool){
     //if trialIsSet != true{
         //trial=t
         //print(trial)
         
         //trialIsSet=true
     //}
     return (true,false)
 
 }
 
 func timeTrial(){
     while elapsedTime != UInt64(TimeInterval(1.0)){
         let trialEnd = DispatchTime.now().uptimeNanoseconds
         elapsedTime = (trialEnd - trialStart)/1000000000
         
         if pressed==false{
             continue
         }
         if pressed==true || pressed==false && elapsedTime == UInt64(TimeInterval(1.0)){
             (keyPressed,rt) = timeBlockWithMach{blockForTimer()}
             break
         }
         
     }
     
     
 }
 
 func collectData(){
     
     trial=trial+1
 }
 
 func sequentialFunctions(_ func1: ()->Bool,_ func2: ()->Bool,_ func3: ()->Void){
     var func1Done=false
     var func2Done=false
     func1Done = func1()
     if func1Done{
         func2Done = func2()
     }
     if func2Done{
         func3()
     }
     
     
 }
 
 func blockForTimer()->Void{
     while pressed != true{
         continue
     }
     
 }
 
 func timeBlockWithMach(_ block: () -> Void) -> (String,TimeInterval,Bool){
     var info = mach_timebase_info()
     guard mach_timebase_info(&info) == KERN_SUCCESS else { return ("-1",-1,false) }
     let start = mach_absolute_time()
     
     block()
     
     let end = mach_absolute_time()
     let elapsed = end - start
     let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
     rt = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
     let done=true
     return (keyPressed,rt,done)
 }
 */
 
 
 
 
override func didMove(to view: SKView){
    if instructionsShown == true{
        canRestart = true
        // set physics
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        startTimer()
        logTrial()
        getBackground()
        getMotoMan()
        getDistractors()
        getDistractorTiming()
        getLasso()
        sceneShown = true
        
    }
}

 
    func startTimer(){
        thisTrial=0
        totalNumSec=0
        trialNumSec=0
        rt=0
        timeInt=0.0001
        
        guard mach_timebase_info(&info) == KERN_SUCCESS else { return print("timing error") }
        
        Timer.scheduledTimer(timeInterval: timeInt,
                             target: self,
                             selector: #selector(self.startTimer2),
                             userInfo: nil,
                             repeats: true)
        
    }
    
    @objc func startTimer2(){
        currentTime = mach_absolute_time()
        let nanos = currentTime * UInt64(info.numer) / UInt64(info.denom)
        
        print(nanos)
    }
    
    func logTrial(){
        print(currentTime)
    
    }
    
    var pressed=Bool()
    @objc func trialTimer(){
        
        if totalNumSec==0{
            pressed=false
            totalNumSec=Double(timeInt)
            //trialNumSec=Double(timeInt)
            rt=Double(timeInt)
        } else {
            
            totalNumSec=totalNumSec+Double(timeInt)
            //trialNumSec=trialNumSec+Double(timeInt)
            if pressed==false{
                rt=rt+Double(timeInt)
            }
            
            
        }
        
        let precision = Double(100)
        let roundedRT=precision*rt/precision
        let roundedITI=precision*Double(expValues.iti)/precision
        
        if floor(roundedRT) == roundedRT{
            print(rt)
        }
        
        //print(rt)
        
        if roundedRT == roundedITI{
            saveTrialData2()
            
            printDataArray()
            
            thisTrial=thisTrial+1
            pressed=false
            rt = 0
        }
        
        /*
        let test = totalNumSec.truncatingRemainder(dividingBy: Double(expValues.iti))
        //let rounded = Double(round(1000000*Double(totalNumSec)/Double(expValues.iti))/1000000)
        let floored = floor(totalNumSec)
        if test == floored{
            //printTrialData()
            saveTrialData2()
            
            printDataArray()
            
            thisTrial=thisTrial+1
            pressed=false
            rt = 0 //rt - Double(expValues.iti)
            
            
        }
 */
        
    }
    
 

 func saveTrialData(){
     /*
     let data = Data.init()
     data.getTrialData(trial: thisTrial, rt: rt, response: keyPress)
      */
     
     newTrial.setValue(rt, forKey: "rt")
     newTrial.setValue(keyPress, forKey: "keyPresses")
     newTrial.setValue(thisTrial, forKey: "trial")
     newTrial.setValue(participantID, forKey: "participantID")
     
     do {
         try context.save()
     } catch {
         print("Failed saving")
     }
     
 }
 
 
 func saveTrialData2(){
     
     //var data = Data.init()
     data.addTrialData(pid: participantID, trial: thisTrial, rt: rt, keyPress: keyPress)
     
     /*Data.trial[thisTrial] = thisTrial
     
     dataArray[thisTrial].append(Data(participantID: "\(participantID)",
                             trial: "\(thisTrial)",
                             rt: "\(rt)",
                             keyPresses: keyPress))
     */
 }
 
 func printTrialData(){
     let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AllTrialData")
     request.returnsObjectsAsFaults = false
     do {
         let result = try context.fetch(request)
         for data in result as! [NSManagedObject] {
             print("---")
             print(data.value(forKey: "rt") as! Double)
             print(data.value(forKey: "keyPresses") as? String ?? "no press")
             print(data.value(forKey: "trial") as! UInt64)
             print(data.value(forKey: "participantID") as! UInt64)
             print("---")
             
             
       }
         
     } catch {
         
         print("Failed")
     }
     
 }
 
 func printDataArray(){
     print("""
         ---
         PID:\(data.participantID)
         trial:\(data.trialArray)
         rt:\(data.rtArray)
         keyPresses:\(data.keyPressArray)
         ---
     """)
     
     
 }
 
 
 override func sceneDidLoad(){
     createInstructionLabel()
     context = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     let trialData = NSEntityDescription.entity(forEntityName: "AllTrialData", in: context)
     newTrial = NSManagedObject(entity: trialData!, insertInto: context)
     
 }
 
 
 
 */






/*
func createMotoMan(){
    // create object texture
    motoTexture = SKTexture(imageNamed: "motorcycle")
    motoTexture.filteringMode = .nearest
    // create object node
    motoMan = SKSpriteNode(texture: motoTexture)
    motoMan.setScale(0.50)
    motoMan.position = CGPoint(x: 0,
                               y: 0)
    motoMan.zPosition = 0.9
    motoMan.physicsBody = SKPhysicsBody(circleOfRadius: motoMan.size.height / 3.0)
    motoMan.physicsBody?.isDynamic = true
    motoMan.physicsBody?.allowsRotation = false
    
    self.addChild(motoMan)
}
 
 func createDistractors(){
     let distractorXPosition = super.frame.width/7.3
     let distractorYPosition = super.frame.height/6.5
     // load distractors
     distTexture = SKTexture(imageNamed: "car")
     let distractor1 = SKSpriteNode(texture: distTexture)
     let distractor2 = SKSpriteNode(texture: distTexture)
     let distractor3 = SKSpriteNode(texture: distTexture)
     let distractor4 = SKSpriteNode(texture: distTexture)
     distractor1.setScale(0.80)
     distractor2.setScale(0.80)
     distractor3.setScale(0.80)
     distractor4.setScale(0.80)
     distractor1.zPosition = 0.9
     distractor2.zPosition = 0.9
     distractor3.zPosition = 0.9
     distractor4.zPosition = 0.9
     distractor1.physicsBody = SKPhysicsBody(circleOfRadius: motoMan.size.height / 3.0)
     distractor2.physicsBody = SKPhysicsBody(circleOfRadius: motoMan.size.height / 3.0)
     distractor3.physicsBody = SKPhysicsBody(circleOfRadius: motoMan.size.height / 3.0)
     distractor4.physicsBody = SKPhysicsBody(circleOfRadius: motoMan.size.height / 3.0)
     distractor1.position = CGPoint(x: distractorXPosition,
                                    y: distractorYPosition)
     distractor2.position = CGPoint(x: -distractorXPosition,
                                    y: distractorYPosition)
     distractor3.position = CGPoint(x: distractorXPosition,
                                    y: -distractorYPosition)
     distractor4.position = CGPoint(x: -distractorXPosition,
                                    y: -distractorYPosition)
     self.addChild(distractor1)
     self.addChild(distractor2)
     self.addChild(distractor3)
     self.addChild(distractor4)
 }
 
 func createLasso(){
     //add and animate lasso
     /*
     let lasso1Texture = SKTexture(imageNamed: "lasso1")
     let lasso2Texture = SKTexture(imageNamed: "lasso2")
     let change = SKAction.animate(with: [lasso1Texture,lasso2Texture], timePerFrame: TimeInterval(1))
     
 
     
     lasso.run(change)
     */
     let lassoTexture = SKTexture(imageNamed: "lasso1")
     lasso = SKSpriteNode(texture: lassoTexture)
     lasso.position = CGPoint(x: motoMan.position.x + super.frame.width/25,
                              y: motoMan.position.y + super.frame.height/14)
     lasso.setScale(2.0)
     lasso.zPosition = 1.0
     
     self.addChild(lasso)
     
     
 }
 
 func createLassoWithPixels(){
     let pixelTexture = SKTexture(imageNamed: "pixel")
     let numberOfPixels = 20
     let lassoNode=SKNode()
     for pixel in 1...numberOfPixels{
         let lassoSprite = SKSpriteNode(texture: pixelTexture)
         lassoSprite.name = "lassoSprite\(pixel)"
         lassoSprite.position = CGPoint(x: pixel*2,
                                        y: pixel)
         lassoSprite.setScale(0.10)
         lassoSprite.zPosition = 1
         lassoNode.addChild(lassoSprite)
     }
     self.addChild(lassoNode)
 }
 
 var background:SKNode!
 func createBackground(){
     // create environment textures
     let roadTexture = SKTexture(imageNamed: "road")
     let moveEnv = SKAction.moveBy(x: 0,
                                   y: -roadTexture.size().height * 2.0,
                                   duration: TimeInterval(0.01 * roadTexture.size().height * 2.0))
     let resetEnv = SKAction.moveBy(x: 0,
                                    y: roadTexture.size().height * 2.0,
                                    duration: 0.0)
     let moveEnvForever = SKAction.repeatForever(SKAction.sequence([moveEnv,resetEnv]))
     // parent node to add child movement nodes to
     background = SKNode()
     // create child nodes that will move bakground forever
     for i in -2 ..< Int(self.frame.size.height / (roadTexture.size().height / 20)) {
         let i = CGFloat(i)
         let sprite = SKSpriteNode(texture: roadTexture)
         
         sprite.setScale(0.2)
         sprite.zPosition = 0
         sprite.position = CGPoint(x: 0,
                                   y: i * sprite.size.height)
         sprite.run(moveEnvForever)
         
         background.addChild(sprite)
     }
     self.addChild(background)
 }
 
 
 /*
 var background:SKNode

 init(){
     background = SKNode()
 }
 //this is jittery, fix at some point
 func moveForever()->SKNode{
     
     let screenSize:CGRect = NSScreen.main!.frame
     
     let roadTexture = SKTexture(imageNamed: "road")
     let move = SKAction.moveBy(x: 0,
                                y: -screenSize.size.height,
                                duration: TimeInterval(10000/roadTexture.size().height))
     let reset = SKAction.moveBy(x: 0,
                                 y: screenSize.size.height,
                                 duration: 0.0)
     let moveForever = SKAction.repeatForever(SKAction.sequence([move,reset]))
     
     for i in Int(-screenSize.size.height) ... Int(screenSize.size.height) {
             let i = CGFloat(i)
             let sprite = SKSpriteNode(texture: roadTexture)
             sprite.name = "\(i)"
             sprite.setScale(0.18)
             sprite.zPosition = 0
             sprite.position = CGPoint(x: 0,
                                       y: i * sprite.size.height)
             sprite.run(moveForever)
             
             background.addChild(sprite)
     }
     return background
 }
 */

 /*
 let screenSize:CGRect = NSScreen.main!.frame

  let posXPosition = CGFloat(screenSize.midX + 12)
 let posYPosition = CGFloat(screenSize.midY + 12)
 let negXPosition = CGFloat(screenSize.midX - 12)
 let negYPosition = CGFloat(screenSize.midY - 12)

  let xPosition = screenSize.size.width/10.4
  let yPosition = screenSize.size.height/4.5
  
  let xPosition = super.frame.width*1.3+2
  let yPosition = super.frame.height
  
  
 let posXPosition = CGFloat(screenSize.midX)
 let posYPosition = CGFloat(screenSize.midY)
 let negXPosition = CGFloat(screenSize.midX)
 let negYPosition = CGFloat(screenSize.midY)


 if position == 1{
     self.position = CGPoint(x: posXPosition,
                             y: posYPosition)
 } else if position == 2{
     self.position = CGPoint(x: negXPosition,
                             y: posYPosition)
 } else if position == 3{
     self.position = CGPoint(x: posXPosition,
                             y: negYPosition)
 } else if position == 4{
     self.position = CGPoint(x: negXPosition,
                             y: negYPosition)
 }
 */

 func getDistractors(){
     let distractor1 = Distractor.init()
     let distractor2 = Distractor.init()
     let distractor3 = Distractor.init()
     let distractor4 = Distractor.init()
     distractor1.createDistractor(position: 1)
     distractor2.createDistractor(position: 2)
     distractor3.createDistractor(position: 3)
     distractor4.createDistractor(position: 4)
     distractor1.resetDistractorOnTimer()
     distractor2.resetDistractorOnTimer()
     distractor3.resetDistractorOnTimer()
     distractor4.resetDistractorOnTimer()
     
     
     self.addChild(distractor1)
     self.addChild(distractor2)
     self.addChild(distractor3)
     self.addChild(distractor4)
     
     
     
     
 }
 
 
 class Distractor:SKSpriteNode{
     
     //var copy:SKSpriteNode
     init(){
         let distTexture = SKTexture(imageNamed: "car")
         super.init(texture: distTexture, color: NSColor.clear, size: distTexture.size())
         self.setScale(1.0)
         self.zPosition = 0.8
         self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 3.0)
         //copy = self.copy() as! SKSpriteNode
         
     }
     
     func createDistractor(position: Int){
         let background = Background.init()
         let backRect = background.scaledSize
         let backHeight = backRect.height
         let backWidth = backRect.width / 3
         
         let posXPosition = backWidth+2
         let negXPosition = -backWidth+10
         let posYPosition = backHeight
         let negYPosition = -backHeight
         
         if position == 1{
             self.position = CGPoint(x: posXPosition,
                                     y: posYPosition)
         } else if position == 2{
             self.position = CGPoint(x: negXPosition,
                                     y: posYPosition)
         } else if position == 3{
             self.position = CGPoint(x: posXPosition,
                                     y: negYPosition)
         } else if position == 4{
             self.position = CGPoint(x: negXPosition,
                                     y: negYPosition)
         }
         
     }
     
     @objc func clearDistractor(){
         let move = SKAction.moveBy(x: 0, y: -100, duration: TimeInterval(1.0))
         let copy = self.copy() as! SKSpriteNode
         copy.removeAllActions()
         //copy.position.y = copy.position.y + 200
         var copyPosition = copy.position.y
         copyPosition = copyPosition + 100
         copy.position.y = copyPosition
         copy.run(move)
         self.addChild(copy)
         
         self.run(move)
         
         
         
     }
     
     func resetDistractorOnTimer(){
         Timer.scheduledTimer(timeInterval: TimeInterval(1.0),
                              target: self,
                              selector: #selector(Distractor.clearDistractor),
                              userInfo: nil,
                              repeats: true)
         
         
     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }

 
*/
