//
//  Service.swift
//  Appstore
//
//  Created by Turan Çabuk on 5.01.2024.
//

import Foundation

class Service {
    
    static let shared = Service() // Singleton
    
    // Service Call
    func fethItunes(searchTerm: String, completion: @escaping ([Result]) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            
            // Error Control
            
            if err != nil {
                print("Failed to fetch apps:")
                return
            }
            
            //Succes
            
            guard let data = data else { return }
            do{
                let searchResult = try
                JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results)
            } catch {
                print("Failed to decode json:", error)
            }
            
        }.resume()
    }
    
    // 1
    func fetchFreeApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        
         let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // 2
    func fetchPaidApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/25/apps.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // 3
    func fetchTopAlbums(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    //Helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            //Error Control
            
            if let err = err {
                
                completion(nil, err)
                print("Failed to fetch the json:", err)
                return
            }
            
            //Succes
            
            do{
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)

                
                completion(appGroup, nil)
            }catch let err{
                
                print("Failed to fetch the json:", err)
            }
        }.resume()
    }
}

