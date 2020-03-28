//
//  AppDelegate.swift
//  macOStest
//
//  Created by Danny Toomey on 10/20/19.
//  Copyright © 2019 Danny Toomey. All rights reserved.
//


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
