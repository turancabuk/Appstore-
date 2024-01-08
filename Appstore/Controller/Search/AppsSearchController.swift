//
//  AppsSearchController.swift
//  Appstore
//
//  Created by Turan Çabuk on 4.01.2024.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellId = "id123"
    
    fileprivate var appResults = [Result]()
    
    var timer: Timer?
    
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchITunesApps()
        
        setSearchController()
    }
    fileprivate func setSearchController() {

        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            Service.shared.fethItunes(searchTerm: searchText) { (res) in
                
                self.appResults = res
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    fileprivate func fetchITunesApps() {
        
        Service.shared.fethItunes(searchTerm: "littlestepsdevelopment") { (results) in
            
            self.appResults = results
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return.init(width: view.frame.width, height: 350)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appResults.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        
        cell.appResult = appResults[indexPath.item]
        
        return cell
    }
}
