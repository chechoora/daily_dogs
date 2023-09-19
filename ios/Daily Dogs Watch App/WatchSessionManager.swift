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
    
    var reachable = false
    var context = [String: Any]()
    var receivedContext = [String: Any]()
    var log = [String]()
    
    override init() {
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        refresh()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async { self.log.append("Received message: \(message)") }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        DispatchQueue.main.async { self.log.append("Received context: \(applicationContext)") }
    }
    
    func refresh() {
        reachable = session.isReachable
        context = session.applicationContext
        receivedContext = session.receivedApplicationContext
    }
    
}
