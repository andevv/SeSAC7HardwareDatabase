//
//  CalendarViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import SnapKit
import RealmSwift

class CalendarViewController: UIViewController {
 
    let tableView = UITableView()
    let calendar = UIView()
    
    //1. default.realm 조회
    let realm = try! Realm()
    
    
    //Results는 클래스 기반 -> 디퍼블 문제 생김
    //[MoneyTable] 구조체 기반 -> 디퍼블 사용 가능
    var list: Results<MoneyTable>!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureHierarchy()
        configureView()
        configureConstraints()
        
        print(realm.configuration.fileURL)
        let data = realm.objects(MoneyTable.self).where({
            $0.category == 1
        }).sorted(byKeyPath: "money", ascending: false)
        list = data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(calendar)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        calendar.backgroundColor = .green
        
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        
        let search = UIImage(systemName: "magnifyingglass")
        let left = UIBarButtonItem(image: search, style: .plain, target: self, action: #selector(searchBarButtonItemClicked))
        
        navigationItem.rightBarButtonItems = [item, left]
    }
    
    private func configureConstraints() {
        
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
         
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchBarButtonItemClicked() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        //하나의 레코드
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.money.formatted() + "원"
        cell.subTitleLabel.text = data.type ? "수입" : "지출"
        cell.overviewLabel.text = data.memo
        cell.thumbnailImageView.image = loadImageToDocument(filename: "\(data.id)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = list[indexPath.row]
        
        do {
            try realm.write {
                realm.create(MoneyTable.self, value: ["id": data.id, "money": 1], update: .modified)
                //realm.delete(data)
            }
        } catch {
            print("데이터 삭제 실패")
        }
        
        list = realm.objects(MoneyTable.self)
        tableView.reloadData()
        
    }
      
    
}
