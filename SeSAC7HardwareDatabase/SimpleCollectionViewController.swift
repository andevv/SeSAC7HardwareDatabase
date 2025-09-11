//
//  SimpleCollectionViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/11/25.
//

import UIKit
import SnapKit

class SimpleCollectionViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var list = ["고래밥", "칙촉", "카스타드", "피자"]
    
    var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.dataSource = self
        configureDataSource()
        

    }
    
    //Flow -> Compositional -> List Configuration
    func createLayout() -> UICollectionViewLayout {
        
        //컬렉션뷰를 테이블뷰처럼 사용
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = .systemGreen
        config.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }

    func configureDataSource() {
        
        
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .brown
            content.textProperties.font = .boldSystemFont(ofSize: 20)
            
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listGroupedCell()
            background.backgroundColor = .yellow
            background.cornerRadius = 40
            
            cell.backgroundConfiguration = background
        })
        
    }
}

extension SimpleCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    //1. 컬렉션뷰는 시스템셀이 없었음 -> 커스텀셀 사용
    // custom cell + identifier + cell register
    //2. iOS14+ 시스템셀이 있어서 사용 가능
    // system cell + X + cellRegistration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: list[indexPath.item])
        
        return cell
    }
    
    
}
