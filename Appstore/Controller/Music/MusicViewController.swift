//
//  MusicViewController.swift
//  Appstore
//
//  Created by Turan Çabuk on 23.01.2024.
//

import UIKit

class MusicViewController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var musics: AppGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellId)
        fetchMusics()
    }
    fileprivate func fetchMusics() {
        
        Service.shared.fetchTopAlbums { (appGroup, err) in
            
            self.musics = appGroup
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics?.feed.title.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
        
        let albums = musics?.feed.results[indexPath.item]
        cell.artistLabel.text = albums?.name
        cell.songLabel.text = albums?.artistName
        cell.imageView.sd_setImage(with: URL(string: albums?.artworkUrl100 ?? ""))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 100)
    }
}
