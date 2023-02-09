//
//  DIDModule.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 10/7/22.
//

import Foundation
import didm_sdk

@objc(DIDModule)
class DIDModule: NSObject {
  
  @objc
  static func requiresMainQueueSetup() ->Bool {
    return false;
  }
  
  @objc
  func getDeviceID(_ callback:@escaping RCTResponseSenderBlock) {
    callback([(DetectID.sdk() as? DetectID)?.getDeviceID() ?? ""])
  }
  
  @objc
  func getMaskedAppInstanceID(_ callback:@escaping RCTResponseSenderBlock) {
    callback([(DetectID.sdk() as? DetectID)?.getMaskedAppInstanceID() ?? ""])
  }
  
  @objc
  func getMobileID(_ callback:@escaping RCTResponseSenderBlock) {
    callback([(DetectID.sdk() as? DetectID)?.getMobileID() ?? ""])
  }
  
  @objc
  func didRegistration(_ url: NSString, resolve:@escaping RCTPromiseResolveBlock, reject:@escaping RCTPromiseRejectBlock) {
    (DetectID.sdk() as? DetectID)?.didRegistration(withUrl: url as String, onSuccess: {
      resolve(nil)
    }, onFailure: { error in
      reject("\(error.code)", error.localizedDescription, error)
    })
  }
  
  @objc
  func didRegistrationByQRCode(_ qrCode: NSString, resolve:@escaping RCTPromiseResolveBlock, reject:@escaping RCTPromiseRejectBlock) {
    (DetectID.sdk() as? DetectID)?.didRegistration(byQRCode: qrCode as String, fromUrl: "", onSuccess: {
      resolve(nil)
    }, onFailure: { error in
      reject("\(error.code)", error.localizedDescription, error)
    })
  }
  
  @objc
  func updateGlobalConfig(_ accountJson: String) {
    guard let account = AccountModule.getAccount(fromJson: accountJson as String) else { return }
    (DetectID.sdk() as? DetectID)?.updateGlobalConfig(account)
  }
  
  @objc
  func isValidPayload(_ payload: [AnyHashable : Any], callback:@escaping RCTResponseSenderBlock) {
    callback(["\((DetectID.sdk() as? DetectID)?.isValidPayload(payload) ?? false)"])
  }
  
  @objc
  func subscribePayload(_ payload: [AnyHashable : Any]) {
    (DetectID.sdk() as? DetectID)?.subscribePayload(payload)
  }
  
  @objc
  func receivePushServiceId(_ data: String) {
  }
  
  @objc
  func setApplicationName(_ data: String) {
    (DetectID.sdk() as? DetectID)?.setApplicationName(data)
  }
  
}
