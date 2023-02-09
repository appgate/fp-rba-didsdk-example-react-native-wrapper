//
//  DIDSDK.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 11/4/22.
//

import UserNotifications
import UIKit
import didm_sdk

@objcMembers
public class DIDSDK: NSObject {
    
    public static let instance: DIDSDK = DIDSDK()
    
    var launchOptions: NSDictionary?
    
    var pushTransactionOpenDelegate: TransactionDelegateProtocol? {
        didSet {
            (DetectID.sdk() as? DetectID)?.getPushApi().pushTransactionOpenDelegate = self
            finishPayloadSubscription()
        }
    }
    
    var pushAlertOpenDelegate: TransactionDelegateProtocol? {
        didSet {
            (DetectID.sdk() as? DetectID)?.getPushApi().pushAlertOpenDelegate = self
            finishPayloadSubscription()
        }
    }
    
    var pushTransactionServerResponseDelegate: TransactionDelegateProtocol? {
        didSet {
            (DetectID.sdk() as? DetectID)?.getPushApi().pushTransactionServerResponseDelegate = self
        }
    }
    
    @objc
    public func registerForRemoteNotifications(_ delegate: UNUserNotificationCenterDelegate) {
        let center = UNUserNotificationCenter.current()
        center.delegate = delegate
        center.requestAuthorization(options: [.sound, .alert, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            } else {
                print(error)
            }
        }
    }
    
    @objc
    public func subscribePayload(_ dictionary: [AnyHashable: Any]?) {
        if let dict = dictionary as? NSDictionary {
          self.launchOptions = dict[UIApplication.LaunchOptionsKey.remoteNotification] as? NSDictionary
        }
    }
    
    private func finishPayloadSubscription() {
        guard let payload = launchOptions else { return }
        self.launchOptions = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            (DetectID.sdk() as? DetectID)?.subscribePayload(payload as! [AnyHashable : Any])
        }
    }
    
}

extension DIDSDK: PushTransactionOpenDelegate {
    
    public func onPushTransactionOpen(_ transaction: TransactionInfo!) {
        self.pushTransactionOpenDelegate?.onReceived(transaction: transaction)
    }
}
extension DIDSDK: PushAlertOpenDelegate {
    
    public func onPushAlertOpen(_ transaction: TransactionInfo!) {
        self.pushAlertOpenDelegate?.onReceived(transaction: transaction)
    }
}
extension DIDSDK: PushTransactionServerResponseDelegate {
    
    public func onPushTransactionServerResponse(_ response: String!) {
        self.pushTransactionServerResponseDelegate?.onReceived(string: response)
    }
}
