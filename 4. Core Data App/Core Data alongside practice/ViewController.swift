//
//  ViewController.swift
//  Core Data alongside practice
//
//  Created by Saman on 26/09/2019.
//  Copyright © 2019 theSamans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var planes = [Plane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            planes = try context.fetch(Plane.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func addPlane() {
        let speed = 10
        let destination = "Paris"
        let plane = Plane(entity: Plane.entity(), insertInto: context)
        plane.speed = Int16(speed)
        plane.destination = destination
        appDelegate.saveContext()
        planes.append(plane)
    }

}
