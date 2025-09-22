//
//  FolderViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import SnapKit
import RealmSwift

class FolderViewController: UIViewController {
    
    let realm = try! Realm()

    let tableView = UITableView()
    
    var list: Results<MoneyFolder>!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
//        createFolder(name: "개인")
//        createFolder(name: "회사")
//        createFolder(name: "동아리")
//        createFolder(name: "가족")
        
        list = realm.objects(MoneyFolder.self)
    }
    
    func createFolder(name: String) {
        
        let folder = MoneyFolder(name: name)
        
        do {
            try realm.write {
                realm.add(folder)
            }
        } catch {
            print("폴더 테이블에 저장 실패")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    private func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
    }
     
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        let data = list[indexPath.row]
        cell.titleLabel.text = data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CalendarViewController()
        let data = list[indexPath.row]
        vc.folder = data
        navigationController?.pushViewController(vc, animated: true)
    }
}
