//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

// The job of this function is to fetch all the repositories from the Github API, and pass that array of dictionaries on to its completion closure.
class GithubAPIClient {
    
    //  How does this method get those objects back to the person who called it? It should take its own closure as an argument, which accepts the array of dictionaries as a parameter and returns nothing.
    class func getRepositoriesWithCompletion(completionHandler: (NSArray) -> ()) {
     
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        if let githubURL = NSURL(string:"https://api.github.com/repositories?client_id=c194d238a5c74f90a895&client_secret=facf16a7789cc412d1a2e6421231ffe8fc1ace8a") {
            
            // This method should know the URL to hit for the API request, create the NSURLSessionDataTask, and kick it off.
            let githubTask = session.dataTaskWithURL(githubURL, completionHandler: { (data, response, error) in
                
                if let data = data {
                    
                    do {
                    
                        // In the completion closure for the data task, the method should deserialize the JSON data from the server.
                        let responseData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
                        
                        NSOperationQueue.mainQueue().addOperationWithBlock({ 
                            
                            completionHandler(responseData)
                            
                            print(responseData)
                            
                        })
                        
                    } catch {
                        
                        print("Error: Fetching Failed.")
                        
                    }
                }
            })
            
            githubTask.resume()
        }
    }
}

