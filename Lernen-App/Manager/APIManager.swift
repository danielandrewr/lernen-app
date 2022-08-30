//
//  APIManager.swift
//  Lernen-App
//
//  Created by Daniel Roong on 29/08/22.
//

import Foundation
import Network
import CoreData

class APIManager: NSObject {
    
    private let networkToken: NSQueryGenerationToken
    private let networkSession: Int
    private let networkURL: URL
    private let handleSession: ((URLSession) -> Void)?
    
    private let semaphore: Semaphore
    
    init(networkToken: NSQueryGenerationToken, networkURL: URL, session: Int, handleSession: ((URLSession) -> Void)?) {
        self.networkToken = networkToken
        self.networkURL = networkURL
        self.networkSession = session
        self.handleSession = handleSession
        self.semaphore = Semaphore(bitPattern: 3)!
    }
    
    // MARK: Requests Fetch Function
    public func fetchRequests(idx: Int, requests: NSArray) {
        let requestsCount = requests.count
        
        // Base Conditon for which the recursion should stop
        guard idx < requestsCount else { return }
        
        var request = URLRequest(url: self.networkURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Fetches data using
            let json = try? JSONSerialization.jsonObject(with: data!) as? [String:Any]
            
            let requestName = json!["requestsName"] as! [String:Any]
            //let body = requestName["value"] as! String
            
            
            // MARK: HERE CONSUMES THE DATA
            // Lanjut di sini mark
        }.resume()
        
    }
    
    public func fetchAll(idx: Int, requests: NSArray) {
        let fetchesCount = requests.count
        
        var requests = URLRequest(url: self.networkURL)
        requests.httpMethod = "GET"
    }
}
