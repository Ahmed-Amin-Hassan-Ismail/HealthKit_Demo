//
//  ViewController.swift
//  HealthKit_Demo
//
//  Created by Ahmed Amin on 23/03/2023.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    var healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestPermission()
        
    }
    

    // MARK: - Request Permission
    
    private func requestPermission() {
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!
        ]
        
        let TypesToWrite: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        healthStore.requestAuthorization(toShare: TypesToWrite, read: typesToRead) { (success, error) in
            
            if success {
                
                print("HealthKit Granted Successfully")
                
            } else {
                
                print("HealthKit Denied !")
                
            }
        }
    }


}

