//
//  LocationViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/9/25.
//

import UIKit
import MapKit
import CoreLocation //1. 프레임워크
import SnapKit


class LocationViewController: UIViewController {
    
    let mapView = MKMapView()
    let button = UIButton()
    
    //2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        //4. 프로토콜 연결
        locationManager.delegate = self
        
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(button.snp.top)
        }
        
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    // 1) iOS 위치 서비스 활성화 여부 확인
    @objc func buttonClicked() {
        
        DispatchQueue.global().async { //백그라운드 스레드에서 실행
            // 1)
            if CLLocationManager.locationServicesEnabled() {
                print("아이폰 위치서비스 켜진 상태, 위치 권한 요청 가능")
                
                // 2)
                DispatchQueue.main.async { //메인에서 실행
                    self.checkCurrentLocationAuthorization()
                }
            } else {
                print("위치 서비스가 꺼져있어 위치 권한 요청을 할 수 없습니다.")
            }
        }
    }
    
    // 2) 현재 사용자 권한 상태 확인 후 얼럿 띄우기 (항상 얼럿이 뜨는 건 아님(UX))
    func checkCurrentLocationAuthorization() {
        
        var status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            print("권한이 아직 결정되지 않은 상태, 여기서만 권한 문구를 띄울 수 있음")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            //앱을 사용하는 동안 허용
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("사용자가 거부한 상태, iOS 설정 창으로 이동하라는 얼럿 띄우기")
        case .authorizedWhenInUse:
            print("사용자가 허용한 상태, 위치 정보를 얻어오는 로직을 구현할 수 있음")
            //didUpdateLocations를 실행시켜 주는 메서드
            locationManager.startUpdatingLocation()
        default: print(status)
        }
    }
}

//3. 위치 프로토콜
extension LocationViewController: CLLocationManagerDelegate {
    
    //didUpdateLocations: 위치를 성공적으로 조회한 경우
    //코드 구성에 따라서 여러번 호출이 될 수도 있음
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations.first?.coordinate)
        
        let region = MKCoordinateRegion(center: locations.first!.coordinate,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
        
        //start 메서드를 썼으면, 더 이상 위치를 얻어올 필요가 없는 시점에서는 stop을 해줘야 함
        locationManager.stopUpdatingLocation()
    }
    
    //didFailWithError: 위치 조회에 실패한 경우 (권한 없을 때)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    //사용자 권한 상태가 변경된 경우 (iOS14 이상)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        buttonClicked()
    }
    
    //사용자 권한 상태가 변경된 경우 (iOS14 미만)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
}
