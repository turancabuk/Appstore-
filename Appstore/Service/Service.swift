//
//  Service.swift
//  Appstore
//
//  Created by Turan Çabuk on 5.01.2024.
//

import Foundation

class Service {
    
    static let shared = Service() // Singleton
    
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
}
