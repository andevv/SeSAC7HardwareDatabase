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
        
//        createAccount(title: "청년절망적금 시즌2")
//        createAccount(title: "전세")
//        createAccount(title: "통신비")
        
        list = realm.objects(MoneyFolder.self)
        dump(list)
    }
    
    func createAccount(title: String) {
        let account = Account(title: title)
        
        let folder = realm.objects(MoneyFolder.self).where {
            $0.name == "개인"
        }.first
        
        do {
            try realm.write {
                folder?.detail.append(account)
            }
        } catch {
            print("realm 데이터에 저장 실패")
        }
        
//        let account = Account(title: title)
//        
//        do {
//            try realm.write {
//                realm.add(account)
//            }
//        } catch {
//            print("account 테이블에 저장 실패")
//        }
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
        cell.subTitleLabel.text = "\(data.detail.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = list[indexPath.row]
        
        do {
            try realm.write {
                realm.delete(data.detail)
                realm.delete(data)
            }
        } catch {
            print("삭제 실패")
        }
        
//        let vc = SearchViewController()
//        let data = list[indexPath.row]
//        vc.account = data.detail
        
//        navigationController?.pushViewController(vc, animated: true)
//        let vc = CalendarViewController()
//        let data = list[indexPath.row]
//        vc.folder = data
//        navigationController?.pushViewController(vc, animated: true)
    }
}
