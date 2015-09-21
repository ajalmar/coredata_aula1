//
//  CarUtils.swift
//  Aula1CRUD
//
//  Created by ajalmar on 22/05/15.
//  Copyright (c) 2015 br.edu.ifce. All rights reserved.
//

import UIKit
import CoreData

extension Car {
    
    class func findByCode(code: String) ->  Car? {
        
        let request = NSFetchRequest(entityName: "Car")

        var predicate = NSPredicate(format: "code = %@", code)
        request.predicate = predicate
        
        var error: NSError?
        var cars = context.executeFetchRequest(request, error: &error) as! [Car]
        
        if let error = error {
            println("Error. \(error), \(error.userInfo)")
            return nil
        }
        
        var c: Car! = nil
        if cars.count == 0 {
            println("Nenhum carro com esse código!")
            return  nil
        } else if cars.count >= 1{
            c = cars[0]
        }
        
        return c
    }

    class func insert(code: String, detail: String) -> Bool {
        
        let aCar = findByCode(code)
        
        if let aCar = aCar {
            
            NSLog("Já existe um carro com o código \(code)!")
            return false
        }
        
        var car = Car()
        
        car.code = code
        car.detail = detail
        
        var error: NSError?
        if !context.save(&error) {
            println("Não foi possível salvar. Erro: \(error), \(error?.userInfo)")
            return false
        }
        
        NSLog("Carro inserido com sucesso!");
        
        return true
    }

    func update(code: String, detail: String) -> Bool {
        
        self.code = code
        self.detail = detail
        
        var error: NSError?
        Car.context.save(&error)
        
        if let error = error{
            println("Não foi possível alterar. Erro: \(error), \(error.userInfo)")
            return false
        }
        
        println("Carro alterado com sucesso!")
        return true
    }

    func remove() -> Bool {
        
        Car.context.deleteObject(self)
        
        var error: NSError?
        Car.context.save(&error)
        
        if let error = error{
            
            println("Não foi possível salvar o Contexto. Erro: \(error), \(error.userInfo)")
            Car.context.rollback()
            return false
        }
        
        println("Carro removido com sucesso!")
        
        return true
    }

    class func findAll() -> [Car]{
        
        let request = NSFetchRequest(entityName: "Car")
        
        var error: NSError?
        var cars = context.executeFetchRequest(request, error: &error) as! [Car]
        
        if let error = error {
            println("Unresolved error \(error), \(error.userInfo)")
            return [Car]()
        }
        
        return cars
    }

    
    class func findByContent(content: String) -> [Car]{
        
        let request = NSFetchRequest(entityName: "Car")
        
        let predicate = NSPredicate(format: "code contains %@", content)
        if !content.isEmpty {
            request.predicate = predicate
        }
        
        let sortDescriptor = NSSortDescriptor(key: "code", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        var error: NSError?
        var cars = context.executeFetchRequest(request, error: &error) as! [Car]
        
        if let error = error {
            println("Unresolved error \(error), \(error.userInfo)")
            return [Car]()
        }
        
        return cars
    }

    
   
}
