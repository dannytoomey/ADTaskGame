//
//  data.swift
//  macOStest
//
//  Created by Danny Toomey on 2/1/20.
//  Copyright © 2020 Danny Toomey. All rights reserved.
//

import Foundation
import CoreData

struct Data {
    var participantID = [Int]()
    var trialArray = [Int]()
    var rtArray = [Double]()
    var keyPressArray = [String]()

    mutating func addTrialData(pid: Int, trial:Int, rt: Double, keyPress: String){
        participantID.append(pid)
        trialArray.append(trial)
        rtArray.append(rt)
        keyPressArray.append(keyPress)
        
    }
    
}

/*
class Data{
    
    var trialStimulusOrder=[Int]()
    var thisTrialArray=[Int]()
    var responseTimeArray=[Double]()
    var responseGivenArray=[String]()
    var accuracy=[Int]()
    init(){
        for trial in 0...expValues.numTrials{
            trialStimulusOrder.append(trial)
        }
    }
    
    func getTrialData(trial: Int, rt: Double, response: String){
        thisTrialArray.append(trial)
        responseTimeArray.append(rt)
        responseGivenArray.append(response)
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
/*
    func saveData(){
        
        let saveTrialArray = thisTrialArray
        let saveRTArray = responseTimeArray
        let saveRespGivenArray = responseGivenArray
        guard saveTrialArray.hasChanges else { return }
        do {
            try saveTrialArray.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        
        //let data = NSEntityDescription.insertNewObjectForEntityForName("")
       
    }
 */
}
*/

