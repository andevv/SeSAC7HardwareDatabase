//
//  SearchViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import SnapKit
import RealmSwift

class SearchViewController: UIViewController {
 
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    let realm = try! Realm()
    
    var list: Results<MoneyTable>!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureHierarchy()
        configureView()
        configureConstraints()
        
        list = realm.objects(MoneyTable.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
        
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
    }
    
    private func configureConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
         
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    } 
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let data = realm.objects(MoneyTable.self).where {
            $0.memo.contains(searchText, options: .caseInsensitive)
        }.sorted(byKeyPath: "money", ascending: false)
        
        list = data
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
         
        let row = list[indexPath.row]
        cell.titleLabel.text = row.memo
        cell.subTitleLabel.text = row.money.formatted()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
