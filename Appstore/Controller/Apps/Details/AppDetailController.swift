//
//  AppDetailController.swift
//  Appstore
//
//  Created by Turan Çabuk on 12.01.2024.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericCall(urlString: urlString) { (result: SearchResult?, err) in
                let app = result?.results.first
                self.appDetails = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId ?? "")/sortby=mostrecent/json?l=en&cc=us"
            Service.shared.fetchGenericCall(urlString: reviewsUrl) { (reviews: Reviews?, err) in

                if let error = err {
                    print("failed to decode reviews:", error)
                    return
                }
                self.reviewsResults = reviews
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var appDetails: Result?
    var reviewsResults: Reviews?
    
    let detailCellId = "detailCellId"
    let prewCellId = "prewCellId"
    let reviewCellId = "reviewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
        collectionView.register(PrewCell.self, forCellWithReuseIdentifier: prewCellId)
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            cell.app = appDetails
            return cell
        }else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prewCellId, for: indexPath) as! PrewCell
            cell.prevHorizontalController.app = appDetails.self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = reviewsResults.self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.item == 0 {
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = appDetails
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            return .init(width: view.frame.width, height: estimatedSize.height)
        }else if indexPath.item == 1{
            return .init(width: view.frame.width, height: 500)
        }else{
            return .init(width: view.frame.width, height: 250)
        }
    }
}
 
