//
//  FISGithubRepository.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubRepository {
    
    // The full name of the repository (e.g., "githubUser/nameOfRepo")
    var fullName : String
    
    // The page for the repository on Github's website
    var htmlURL : NSURL
    
    // The ID of the repository.
    var repositoryID : String
    
    // Now we need some way to turn our dictionaries into instances of GithubRepository. Let's do this by giving the class a custom initializer, init(dictionary:), that will take in a dictionary from the API and assign the properties based on the values in that dictionary. The relevant dictionary keys are "full_name", "id", and "html_url".
    init(dictionary: NSDictionary) {
        
        // Since all data from APIs come back as Optionals, we always have to unwrap them--especially in our initializers.
        if let name = dictionary["full_name"] as? String {
            
            self.fullName = name
        
        } else {
            
            self.fullName = "No fullName"
        }
        
        // if the value from the dictionary is a String, then we can take that string and put it into the string parameter for the NSURL function. This is called optional chaining. 
        if let urlString = dictionary["html_url"] as? String, htmlURL = NSURL(string: urlString) {
            
            self.htmlURL = htmlURL
        
        } else {
            
            self.htmlURL = NSURL(string: "www.google.com")!
        }
        
        // Since all data from APIs come back as Optionals, we always have to unwrap them--especially in our initializers.
        if let repositoryID = dictionary["id"] as? NSNumber {
            
            // We could have also done: self.repositoryID = String(repositoryID) if we had downcasted the dictionary to an Int.
            self.repositoryID = repositoryID.stringValue // NSNumber has a method called String value.
        
        } else {
        
            self.repositoryID = "No repositoryID"
        }
    }
}
