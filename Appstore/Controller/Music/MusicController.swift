//
//  MusicController.swift
//  Appstore
//
//  Created by Turan Çabuk on 23.01.2024.
//

import UIKit

class MusicController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let footerId = "footerId"
    fileprivate var searchTerm = "taylor"
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
            
        fetchAlbums()
        
    }
    fileprivate func fetchAlbums() {
        
        let urlString = "https://itunes.apple.com/search?term=taylor&offset=0&limit=20"
        Service.shared.fetchGenericCall(urlString: urlString) { (searchResult: SearchResult?, err) in

            if  err != nil {
                fatalError()
            }else{
                
                self.results = searchResult?.results ?? []
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
        let albums = self.results[indexPath.item]
        cell.songLabel.text = albums.trackName
        cell.artistLabel.text = "\(albums.artistName ?? "") * \(albums.collectionName ?? "")"
        cell.imageView.sd_setImage(with: URL(string: albums.artworkUrl100))
        
        if indexPath.item == results.count - 1 {
            
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            Service.shared.fetchGenericCall(urlString: urlString) { (searchResult: SearchResult?, err) in

                if  err != nil {
                    fatalError()
                }
                sleep(1)
                self.results += searchResult?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}




