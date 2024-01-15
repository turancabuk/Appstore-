//
//  AppsPageController.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import UIKit


class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {

    let cellId = "id"
    let headerId = "headerId"
    var groups = [AppGroup]()
    let dispatchGroup = DispatchGroup()
    var appGroup1: AppGroup?
    var appGroup2: AppGroup?
    var appGroup3: AppGroup?
    var socialApps = [SocialApps]()
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        
        fetchData()
        
        
        
    }
    fileprivate func fetchData() {

        self.dispatchGroup.enter()
        Service.shared.fetchFreeApps { (appGroup, Error) in
            self.dispatchGroup.leave()
            self.appGroup1 = appGroup
        }
        
        self.dispatchGroup.enter()
        Service.shared.fetchPaidApps { (appGroup, Error) in
            self.dispatchGroup.leave()
            self.appGroup2 = appGroup
        }
        
        self.dispatchGroup.enter()
        Service.shared.fetchTopAlbums { (appGroup, Error) in
            self.dispatchGroup.leave()
            self.appGroup3 = appGroup
        }
        self.dispatchGroup.enter()
        Service.shared.fetchSocialApps { (app, Error) in
            self.dispatchGroup.leave()
            self.socialApps = app ?? []
        }
        self.dispatchGroup.notify(queue: .main) {
            
            if let group = self.appGroup1 {
                self.groups.append(group)
            }
            if let group = self.appGroup2 {
                self.groups.append(group)
            }
            if let group = self.appGroup3 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        
        header.appHeaderHorizontalController.socialApps = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 300)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let appGroups = groups[indexPath.item]
        
        cell.titleLabel.text = appGroups.feed.title
        cell.horizontalController.appGroup = appGroups
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [weak self] FeedResult in
            
            let controler = AppDetailController(appId: FeedResult.id)
            controler.navigationItem.title = FeedResult.name
            self?.navigationController?.pushViewController(controler, animated: true)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return.init(width: view.frame.width, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
