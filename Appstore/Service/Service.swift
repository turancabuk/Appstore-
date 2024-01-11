//
//  Service.swift
//  Appstore
//
//  Created by Turan Çabuk on 5.01.2024.
//

import Foundation

class Service {
    
    static let shared = Service() // Singleton
    
    
    //Generic Network Call
    func fetchGenericCall<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            //Error Control
            
            if err != nil {
                
                completion(nil, err)
                return
            }
            
            //Succes
            
            do{
                let results = try JSONDecoder().decode(T.self, from: data!)
                completion(results, nil)
            }catch let err{
                print("Failed to fetch the json:", err)
            }
        }.resume()
    }
    
    // 1
    func fetchFreeApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        
         let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        
        fetchGenericCall(urlString: urlString, completion: completion)
    }
    
    // 2
    func fetchPaidApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/25/apps.json"
        
        fetchGenericCall(urlString: urlString, completion: completion)
    }
    
    // 3
    func fetchTopAlbums(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json"
        
        fetchGenericCall(urlString: urlString, completion: completion)
    }
    

    
    //Social Apps
    func fetchSocialApps(completion: @escaping ([SocialApps]?, Error?) -> Void) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        

        fetchGenericCall(urlString: urlString, completion: completion)
    }
    
    //Search Call
    func fethItunes(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
            
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
 
            fetchGenericCall(urlString: urlString, completion: completion)
    }
}

