//
//  PhotoPickerViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/10/25.
//

import UIKit
import PhotosUI //iOS14+
import SnapKit

class PhotoPickerViewController: UIViewController {
    
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        imageView.backgroundColor = .lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
        config.filter = .any(of: [.screenshots, .images])
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension PhotoPickerViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(#function)
        
        picker.dismiss(animated: true)
    }
    
    
    
    
}
