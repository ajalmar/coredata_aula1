//
//  TableViewController.swift
//  Aula1CRUD
//
//  Created by ajalmar on 19/03/15.
//  Copyright (c) 2015 br.edu.ifce. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, WriteDataBack {
        
    /*
    var cars = ["gol", "palio", "fiesta"]
    var carDetails = ["VW Gol 1.6", "Palio 1.6 16V", "Fiesta 1.0 4p"]
    */
    
    var cars = [String]()
    var carDetails = [String]()

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        var carsMO = Car.findAll()
        
        for carMO in carsMO {
            cars.append(carMO.code)
            carDetails.append(carMO.detail)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return cars.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = cars[indexPath.row]
        cell.detailTextLabel?.text = carDetails[indexPath.row]

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("segueEditCar", sender: self)
        
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            var car = Car.findByCode(cars[indexPath.row])
            car!.remove()

            cars.removeAtIndex(indexPath.row)
            carDetails.removeAtIndex(indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueEditCar"{
        
            var detailVC = segue.destinationViewController as! DetailViewController

            var row: Int! = self.tableView.indexPathForSelectedRow()?.row
            
            detailVC.delegate = self
            detailVC.index = row
            detailVC.code = cars[row]
            detailVC.detail = carDetails[row]
            
        } else if segue.identifier == "segueAddCar"{
            
            var detailVC = segue.destinationViewController as! DetailViewController
            
            var row: Int! = self.tableView.indexPathForSelectedRow()?.row
        
            detailVC.delegate = self
            detailVC.index = -1
            detailVC.code = ""
            detailVC.detail = ""
        }
        
        
        
    }
    
    @IBAction func clickOnAddCarro(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("segueAddCar", sender: self)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.tableView.reloadData()
        
    }
    
    
    func update(index: Int, code: String, detail: String) {
        
        if index == -1 { // carro novo
            
            let inserted = Car.insert(code, detail: detail)
            
            if inserted {
                cars.append(code)
                carDetails.append(detail)
            }

        } else { // atualizar carro
            
            var car = Car.findByCode(code) // busca o carro

            if car!.update(code, detail: detail) {
                carDetails[index] = detail
            }

        }
        
        self.tableView.reloadData()
        
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        
        var theCars = Car.findByContent(searchText)
        
        cars = []
        carDetails = []
        
        for car in theCars {
            cars.append(car.code)
            carDetails.append(car.detail)
        }
        
        self.tableView.reloadData()
        
        NSLog("Pesquisando por: \(searchBar.text)")
    }
    
    
}
