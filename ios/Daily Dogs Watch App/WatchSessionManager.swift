//
//  WatchSessionManager.swift
//  Daily Dogs Watch App
//
//  Created by Kyrylo Kharchenko on 19.09.2023.
//

import Foundation
import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    private let session = WCSession.default
    
    private var reachable = false
    private var context = [String: Any]()
    private var receivedContext = [String: Any]()
    private var log = [String]()
    var onMessageRecived: (([String: Any]) -> ())?
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    func startSession() {
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        refresh()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            self.onMessageRecived?(message)
        }
    }
    
    func refresh() {
        reachable = session.isReachable
        context = session.applicationContext
        receivedContext = session.receivedApplicationContext
    }
    
}
