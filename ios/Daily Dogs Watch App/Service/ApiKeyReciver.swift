//
//  TokenReciver.swift
//  Daily Dogs Watch App
//
//  Created by Kyrylo Kharchenko on 23.09.2023.
//

import Foundation

class ApiKeyReciver {
    
    let defaults = UserDefaults.standard
    private var isKeyObtained: Bool = false
    
    private var watchSesseionManager = WatchSessionManager()
    
    func fetchApiKey(onApiKeyObtained: @escaping ((String) -> ())) {
        if let storedKey = defaults.string(forKey: defaultApiKey) {
            isKeyObtained = true
            onApiKeyObtained(storedKey)
        } else {
            watchSesseionManager.onMessageRecived = { message in
                if let key = self.processMessage(message: message) {
                    onApiKeyObtained(key)
                }
            }
            watchSesseionManager.startSession()
        }
    }
    
    fileprivate func processMessage(message: [String: Any]) -> String? {
        if let apiKey = message[defaultApiKey] as? String {
            if (!self.isKeyObtained) {
                self.saveApiKeyToDefaults(apiKey: apiKey)
                return apiKey
            }
        }
        return nil
    }
    
    fileprivate func saveApiKeyToDefaults(apiKey: String) {
        isKeyObtained = true
        defaults.setValue(apiKey, forKey: defaultApiKey)
    }
    
}

let defaultApiKey = "apiKey"
