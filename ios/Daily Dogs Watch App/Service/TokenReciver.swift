//
//  TokenReciver.swift
//  Daily Dogs Watch App
//
//  Created by Kyrylo Kharchenko on 23.09.2023.
//

import Foundation

class TokenReciver {
    
    let defaults = UserDefaults.standard
    private var isTokenObtained: Bool = false
    var onTokenObtained: ((String) -> ())?
    
    private var watchSesseionManager = WatchSessionManager()
    
    func startTokenCheck() {
        watchSesseionManager.onMessageRecived = { message in
            self.processMessage(message: message)
        }
        if let storedToken = defaults.string(forKey: "apiKey") {
            isTokenObtained = true
            self.onTokenObtained?(storedToken)
        } else {
            watchSesseionManager.startSession()
        }
    }
    
    fileprivate func saveTokenToDefaults(token: String) {
        defaults.setValue(token, forKey: "apiKey")
    }
    
    fileprivate func processMessage(message: [String: Any]) {
        if let token = message["apiKey"], token is String {
            let stringToken = token as! String
            if (!self.isTokenObtained) {
                self.saveTokenToDefaults(token: stringToken)
                self.onTokenObtained?(stringToken)
            }
        }
    }
    
}
