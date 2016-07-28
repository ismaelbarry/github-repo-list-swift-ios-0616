//
//  FISReposDataStore.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    
    var dataStoreRepositoryArray: [GithubRepository] = []
    
    // Now we're in the same boat as in the API client, where we have some result that we got asynchronously and need to inform our caller that we're done. This means the getRepositoriesWithCompletion(completion:) needs its own completion closure. Just make this one take no arguments and return nothing (so its type will be () -> ()).
    func getRepositoriesWithCompletion(completionHandler: () -> ()) {
        
        GithubAPIClient.getRepositoriesWithCompletion { (arrayFromAPI) in
            
            // Since this is a shard dataStore, we have to clear the array just in case there is old stuff here.
            self.dataStoreRepositoryArray.removeAll()
            
            for i in arrayFromAPI {
                
                // The completion closure to the API client function should use the init(dictionary:) method on GithubRepository to turn the dictionaries you receive into repository objects.
                let eachDictionaryInArray = GithubRepository(dictionary: i as! NSDictionary)
                
                // Each of the repository objects should be appended to the data store's repositories array.
                self.dataStoreRepositoryArray.append(eachDictionaryInArray)
            }
            
            if self.dataStoreRepositoryArray.count > 0 {
            
                completionHandler()
            }
            
            print(arrayFromAPI)
        }
    }
}
