//
//  AppDelegate.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/8/25.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        migration()
        
        let realm = try! Realm()
        
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
        
        return true
    }
    
    func migration() {
        
        let config = Realm.Configuration(schemaVersion: 3) { migration,
            oldSchemaVersion in
            
            //Diary에서 favorite 컬럼 제거
            //단순한 컬럼, 테이블 추가 삭제 같은 경우 마이그레이션 코드가 필요 없음
            if oldSchemaVersion < 1 { }
            
            //content 컬럼을 memo 컬럼으로 변경
            if oldSchemaVersion < 2 {
                migration.renameProperty(onType: Diary.className(), from: "content", to: "memo")
            }
            
            //favorite 컬럼 새로 만들고, false로 기본값 지정
            if oldSchemaVersion < 3 {
                migration.enumerateObjects(ofType: Diary.className()) {
                    oldObject, newObject in
                    guard let newObject = newObject else { return }
                    newObject["favorite"] = false
                }
            }
            
        }
            
        Realm.Configuration.defaultConfiguration = config
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

