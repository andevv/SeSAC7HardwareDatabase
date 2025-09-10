//
//  NetworkViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/10/25.
//

//URLSession, Alamofire
import UIKit

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo1: Int
}

class NetworkViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        callRequest()
        
    }
    
    func callRequest() {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1150")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            //에러가 있다면 에러 상황
            if let error = error {
                DispatchQueue.main.async {
                    print("네트워크 오류가 발생했습니다.", error)
                }
                return
            }
            
            //에러가 nil이면 통신 성공
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    print("상태코드 에러")
                }
                return
            }
            
            //상태코드 200인 상황
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    print(result)
                    
                    DispatchQueue.main.async {
                        self.navigationItem.title = result.drwNoDate
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("디코딩 오류")
                    }
                }
            }
            
        }.resume()
        
    }
    
    
}
