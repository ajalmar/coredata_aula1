//
//  Car.swift
//  Aula1CRUD
//
//  Created by ajalmar on 22/05/15.
//  Copyright (c) 2015 br.edu.ifce. All rights reserved.
//

import UIKit
import CoreData

class Car: NSManagedObject {
   
    
    @NSManaged var code: String
    @NSManaged var detail: String
    
    class var context: NSManagedObjectContext! {
        
        let delegate = (UIApplication.sharedApplication()).delegate as! AppDelegate
        return delegate.managedObjectContext!
    }
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity , insertIntoManagedObjectContext: context)
    }
    
    convenience init() {
        
        // chama o construtor da classe
        self.init(entity: NSEntityDescription.entityForName("Car", inManagedObjectContext: Car.context)!, insertIntoManagedObjectContext:Car.context)
    }
    

    
}
