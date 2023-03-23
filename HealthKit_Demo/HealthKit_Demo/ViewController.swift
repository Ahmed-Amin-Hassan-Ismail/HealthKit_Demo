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

    
    
    //MARK: - Tracking Physical Activity
    
    private func trackingUsersSteps() {
        
        let stepCounts = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())

        let query = HKSampleQuery(
            sampleType: stepCounts,
            predicate: predicate,
            limit: Int(HKObjectQueryNoLimit),
            sortDescriptors: nil) { query, results, errors in
                guard let samples = results as? [HKQuantitySample] else { return }
                
                let totalSteps = samples.reduce(0, {$0 + $1.quantity.doubleValue(for: HKUnit.count())})
                print("last 7 days step count : \(totalSteps)")
            }
        
        healthStore.execute(query)
    }

}

