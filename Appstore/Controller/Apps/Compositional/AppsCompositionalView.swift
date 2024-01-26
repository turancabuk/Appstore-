//
//  AppsCompositionalView.swift
//  Appstore
//
//  Created by Turan Çabuk on 24.01.2024.
//

import SwiftUI

class CompositionalController: UICollectionViewController {
    
    var socialApps = [SocialApps]()
    var freeApps: AppGroup?
    var paidApps: AppGroup?
    var albums: AppGroup?
    var appGroup: AppGroup?
    var activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.hidesWhenStopped = true
        aiv.startAnimating()
        return aiv
    }()
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                return CompositionalController.topSection()
            }else{
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1), 
                    heightDimension: .fractionalHeight(1/3)))
                item.contentInsets = .init(
                    top: 0, leading: 0, bottom: 16, trailing: 16)
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                        widthDimension: .fractionalWidth(0.8), 
                        heightDimension: .absolute(300)),
                        subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)),
                        elementKind: kind,
                        alignment: .topLeading)
                ]
                return section
            }
        }
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: "smallCellId")
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        fetchDispatchGroup()
    }
    static func topSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize:.init(
            widthDimension:.fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        
        let group = NSCollectionLayoutGroup.horizontal( layoutSize: .init(
                widthDimension: .fractionalWidth(0.8), 
                heightDimension: .absolute(300)),
                subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 16
        return section

    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
               4
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return socialApps.count
        case 1:
            return freeApps?.feed.results.count ?? 0
        case 2:
            return paidApps?.feed.results.count ?? 0
        default:
            return albums?.feed.results.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppsHeaderCell
            cell.socialApps = self.socialApps[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCellId", for: indexPath) as! AppRowCell
            switch indexPath.section {
            case 1:
                self.appGroup = freeApps
            case 2:
                self.appGroup = paidApps
            default:
                self.appGroup = albums
            }
            cell.app = appGroup?.feed.results[indexPath.item]
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let appId = socialApps[indexPath.item].id
            let detailController = AppDetailController(appId: appId)
            navigationController?.pushViewController(detailController, animated: true)
        case 1:
            let appId = freeApps?.feed.results[indexPath.item].id
            let detailController = AppDetailController(appId: appId ?? "")
            navigationController?.pushViewController(detailController, animated: true)
        case 2:
            let appId = paidApps?.feed.results[indexPath.item].id
            let detailController = AppDetailController(appId: appId ?? "")
            navigationController?.pushViewController(detailController, animated: true)
        default:
            return
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! CompositionalHeader
        
        switch indexPath.section {
        case 0:
            header.label.text = self.socialApps.description
        case 1:
            header.label.text = self.freeApps?.feed.title
        case 2:
            header.label.text = self.paidApps?.feed.title
        default:
            header.label.text = self.albums?.feed.title
        }
        return header
    }
}
class CompositionalHeader: UICollectionReusableView {
    
    let label = UILabel(text: "", Font: .boldSystemFont(ofSize: 32))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.fillSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
extension CompositionalController {
    
    func fetchDispatchGroup() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (app, err) in
            self.socialApps = app ?? []
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        Service.shared.fetchFreeApps { (apps, err) in
            self.freeApps = apps
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        Service.shared.fetchPaidApps { (apps, err) in
            self.paidApps = apps
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        Service.shared.fetchTopAlbums { (albums, err) in
            self.albums = albums
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
struct AppsView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<AppsView>) -> UIViewController {
        let controller = CompositionalController()
        return UINavigationController(rootViewController: controller)
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AppsView>) {
    }
    typealias UIViewControllerType = UIViewController
}
struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .edgesIgnoringSafeArea(.all)
    }
}
