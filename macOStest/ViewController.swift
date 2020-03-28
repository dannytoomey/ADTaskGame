//
//  ViewController.swift
//  macOStest
//
//  Created by Danny Toomey on 10/20/19.
//  Copyright © 2019 Danny Toomey. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    
    var window:NSWindow?
    
    @IBOutlet var skView: SKView!
    
    //why doesn't this work?
    /*
    func resize() {
        var windowFrame = skView.frame
        let oldWidth = windowFrame.size.width
        let oldHeight = windowFrame.size.height
        let toAdd = CGFloat(100)
        let newWidth = oldWidth + toAdd
        let newHeight = oldHeight + toAdd
        windowFrame.size = CGSize(width:newWidth, height:newHeight)
        skView.setFrameSize(CGSize(width:newWidth, height:newHeight))
        
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this doesn't reset the frame origin
        super.view.setFrameOrigin(NSPoint(x:200,y:200))
        
        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}


