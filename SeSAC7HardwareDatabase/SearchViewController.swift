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
    
    var list: [String] = []
      
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureHierarchy()
        configureView()
        configureConstraints()
        
        list = ["A", "B", "C", "D"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
         
        cell.testUI()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
