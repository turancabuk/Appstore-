//
//  MultipleAppsController.swift
//  Appstore
//
//  Created by Turan Çabuk on 18.01.2024.
//

import UIKit

class MultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var results =  [FeedResult]()
    fileprivate let mode: Mode
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullscreen {
            setupCloseButton()
            navigationController?.navigationBar.isHidden = true
        }
        collectionView.register(MultipleAppsCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override var prefersStatusBarHidden: Bool { return true }

    
    func setupCloseButton() {
        
        view.addSubview(closeButton)
        
        closeButton.anchor(
            top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(
                top: 50, left: 0, bottom: 0, right: 16), size: .init(
                    width: 44, height: 44))
    }
    
    @objc func handleDismiss() {
        
        dismiss(animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return results.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppsCell
        cell.results = results[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appId = self.results[indexPath.item].id
        let detailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(detailController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if mode == .fullscreen {
            return .init(width: view.frame.width - 48, height: 64)
        }else{
            return .init(width: view.frame.width, height: 64)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mode == .fullscreen {
            
            return .init(
                top: 50, left: 24, bottom: 12, right: 24)
        }
        
        return .zero
    }
    enum Mode {
        case small, fullscreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
