//
//  NasaViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/11/25.
//

import UIKit

enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
     
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}

class NasaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        callRequestDelegate()
    }
    
    func callRequestDelegate() {
        print(#function)
        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: Nasa.photo).resume()
    }
    
    func callRequest() {
        print(#function)
        URLSession.shared.dataTask(with: Nasa.photo) { data, response, error in
            print(">>>>>>>>>>>>", data)
            //completionHandler는 100% 완료 전까지는 신호를 받지 못함.
            //100% 완료 후 한 번만 클로저가 실행됨
        }.resume()
    }
}

extension NasaViewController: URLSessionDataDelegate {
    
    //1. 서버에서 최초로 응답 받은 경우에 호출 (상태코드에 대한 확인)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("1111")
        completionHandler(.allow)
    }
    
    //2. 서버에서 데이터를 받아올 때마다 반복적으로 호출 (data)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("2222", data)
    }
    
    //3. 오류가 발생했거나 응답이 완료가 될 때 호출 (100% 시점)
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print("3333", error)
    }
    
}
