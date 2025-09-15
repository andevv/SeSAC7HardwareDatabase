//
//  PhotoCollectionViewCell.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/15/25.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let id = "PhotoCollectionViewCell"
    
    let label = {
        let view = UILabel()
        view.textColor = .red
        return view
    }()
    
   let mainImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .green
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        contentView.addSubview(mainImageView)
        contentView.addSubview(label)
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}
