//
//  BasicCollectionViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/15/25.
//

import UIKit
import SnapKit

/*
 로컬 데이터 저장: UserDefaults vs Database(Realm, CoreData, SwiftData)
 */

//Identifiable: id 프로퍼티 사용해라
struct Basic: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let age: Int
}

class BasicCollectionViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
        case sub
        case caption
    }
 
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    //<섹션을 구분해주는 데이터 타입, 셀의 데이터 타입>
    private var dataSource: UICollectionViewDiffableDataSource<Section, Basic>!
 
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Basic>!
    
    //Hashable한데 데이터가 같으면 어떻게 보일지 테스트 필요함
    var list = [
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
        updateSnapshot()
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Basic>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .caption)
        snapshot.appendItems([Basic(name: "새싹", age: 10), Basic(name: "as", age: 123)], toSection: .main)
        snapshot.appendItems([Basic(name: "asdasd", age: 11)], toSection: .sub)
        
        // 중복된 모델은 알아서 고유값을 가지도록 병합됨
        snapshot.appendItems([Basic(name: "새싹", age: 10)], toSection: .main)
        
        dataSource.apply(snapshot)
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
        
        //UICollectionViewDataSource Protocol 대체
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.registration, for: indexPath, item: itemIdentifier)
            
            return cell
        }
    }
}

extension BasicCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //diffable -> index 기반 조회는 되긴 하지만 맞는 접근 아님.
        //print(indexPath)
        //print(list[indexPath.item])
        
        let item = dataSource.itemIdentifier(for: indexPath)
        print(item)
    }
    
}

extension BasicCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let data = Basic(name: searchBar.text!, age: .random(in: 1...100))
        list.insert(data, at: .random(in: 0...3))
        updateSnapshot()
    }
    
}
    //1. Custom Cell + register + identifier
    //2. System Cell + Cell Resgistration + X


extension BasicCollectionViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        view.addSubview(searchBar)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
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
