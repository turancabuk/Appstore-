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
    var closeButton: UIButton = {
        var button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullScreen {
            setupCloseButton()
        }
        collectionView.register(MultipleAppsCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    func setupCloseButton() {
        
        view.addSubview(closeButton)
        closeButton.anchor(
            top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(
                top: 20, left: 0, bottom: 0, right: 16), size: .init(
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 64)
    }
    
    enum Mode {
        case fullScreen, small
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
