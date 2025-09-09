//
//  CameraViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/9/25.
//

import UIKit
import SnapKit

/*
 시뮬레이터로 카메라 촬영 불가 - 테스트 시 실기기 연결 필요
 카메라가 없는 아이폰이 있을 수 있음
 
 - 가능한 것들 -
 1. 카메라로 촬영
 2. 갤러리에서 사진 가져오기
 3. 사진을 갤러리에 저장하기
 -> iOS13까지 UIImagePickerController가 담당 (시스템UI -> 갤러리에서 여러장 선택하는 것 불가능)
 -> iOS14부터 PHPicker(out of process)가 등장 (2, 3번 기능 담당)
 
 */

class CameraViewController: UIViewController {
    
    let manager = UIImagePickerController()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        imageView.backgroundColor = .lightGray
        manager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.sourceType = .photoLibrary
        manager.allowsEditing = true
        
        present(manager, animated: true)
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //갤러리 화면에서 이미지를 선택한 경우
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        let image = info[.editedImage] as? UIImage
        
        if let image = image {
            print("이미지 있음")
            imageView.image = image
            dismiss(animated: true)
        } else {
            print("잘못된 이미지")
        }
    }
    
    //갤러리 화면에서 취소 버튼을 누른 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
    
    
    
}
