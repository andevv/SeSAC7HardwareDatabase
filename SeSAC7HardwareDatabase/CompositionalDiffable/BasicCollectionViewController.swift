//
//  BasicCollectionViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/15/25.
//

import UIKit
import SnapKit

struct Basic {
    let name: String
    let age: Int
}

class BasicCollectionViewController: UIViewController {
 
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
 
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Basic>!
    
    let list = [
        Basic(name: "Jack", age: 123),
        Basic(name: "Den", age: 13),
        Basic(name: "Finn", age: 1234),
        Basic(name: "Bran", age: 11),
        Basic(name: "Hue", age: 55)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureCellRegistration()
    }
    
    //UICollectionViewFlowLayout -> CompositionalLayout -> ListConfiguration
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemYellow
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureCellRegistration() {
        print(#function)
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            print("cell registration", indexPath)
            var content = UIListContentConfiguration.valueCell() // systemCell
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = "\(itemIdentifier.age)세"
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listGroupedCell()
            background.backgroundColor = .lightGray
            cell.backgroundConfiguration = background
        }
    }
}

extension BasicCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    //1. Custom Cell + register + identifier
    //2. System Cell + Cell Resgistration + X
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("cellForItemAt", indexPath)
        let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: list[indexPath.row])
        
        return cell
    }
}

extension BasicCollectionViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
         
        collectionView.backgroundColor = .clear
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
 
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
