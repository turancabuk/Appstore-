//
//  TodayController.swift
//  Appstore
//
//  Created by Turan Çabuk on 16.01.2024.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appFullscreenController: AppFullscreenController!
    var appResults = [Result]()
   
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var startingFrame: CGRect?
    
    var items = [TodayItem]()
    var dispatchGroup = DispatchGroup()
    var freeApps: AppGroup?
    var paidApps: AppGroup?
    
    var activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.hidesWhenStopped = true
        aiv.startAnimating()
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        
        fetchData()
    }
    fileprivate func fetchData() {
        
        dispatchGroup.enter()
        Service.shared.fetchPaidApps { (appGroup, err) in
            
            self.paidApps = appGroup
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchFreeApps { (appGroup, err) in
            
            self.freeApps = appGroup
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            
            self.items = [
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), celltype: .single, apps: []),
                TodayItem.init(category: "Daily List", title: self.paidApps?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, celltype: .multiple, apps: self.paidApps?.feed.results ?? []),
                TodayItem.init(category: "LIFE HACK", title: "Utilizing Your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, celltype: .single, apps: self.freeApps?.feed.results ?? []),
                TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive These Carplay Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, celltype: .multiple, apps: self.freeApps?.feed.results ?? [])
            ]
            self.collectionView.reloadData()
        }
    }
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = MultipleAppsController(mode: .fullscreen)
        fullController.results = self.items[indexPath.item].apps
        let navController = UINavigationController(rootViewController: fullController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    @objc func handleRemoveRedView() {
        self.navigationController?.navigationBar.isHidden = false
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.tableView.contentOffset = .zero
            
            guard let startingFrame = self.startingFrame else { return }
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 68
            cell.layoutIfNeeded()
            
        }, completion: { _ in
            self.appFullscreenController.view.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.item].celltype.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(handleMultipleAppsTap)))
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch items[indexPath.item].celltype {
            
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullScreen(indexPath: indexPath)
        }

    }
    fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {

        // #1 setup fullscreen Controller
        setupSingleAppFullscreenController(indexpath: indexPath)
        // #2 setup fullscreen in its startşng position
        setupAppFullscreenStartingPoistion(indexPath: indexPath)
        // #3 begin the fullscreen animation
        beginAnimationFullscreen()
    }
    fileprivate func setupSingleAppFullscreenController( indexpath: IndexPath) {
        
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexpath.row]
        appFullscreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        self.appFullscreenController = appFullscreenController 
        appFullscreenController.view.layer.cornerRadius = 16
    }
    fileprivate func setupAppFullscreenStartingPoistion(indexPath: IndexPath) {
        
        let fullscreenView = appFullscreenController.view!
        view.addSubview(fullscreenView)
        addChild(appFullscreenController)
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
    }
    fileprivate func beginAnimationFullscreen() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded() // starts animation
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
        }, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    @objc func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
        
        let collectionView = gesture.view
        var superView = collectionView?.superview
        
        while superView != nil {
            if let cell = superView as? TodayMultipleAppCell {
                
                guard let indexPath = self.collectionView.indexPath(for: cell) else {return}
                showDailyListFullScreen(indexPath)
            }
            superView = superView?.superview
        }
    }
}

