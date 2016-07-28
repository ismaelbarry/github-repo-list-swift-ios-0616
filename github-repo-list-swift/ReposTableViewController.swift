//
//  FISReposTableViewController.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    var store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
    
        // When we are complete with the API request, we reload the tableView.
        self.store.getRepositoriesWithCompletion { 
            
            // All UI elements must occure on the main queue.
            NSOperationQueue.mainQueue().addOperationWithBlock({
                
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.store.dataStoreRepositoryArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
        
        let repo = self.store.dataStoreRepositoryArray[indexPath.row]
        
        cell.textLabel?.text = repo.fullName
        
        return cell
    }
}