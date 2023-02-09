//
//  AccountModule.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 10/11/22.
//

import Foundation
import didm_sdk

@objc(AccountModule)
class AccountModule: NSObject {
  
  private static let REFRESH_ACCOUNTS_WAIT_TIME = 0.5
  private static let ERROR_MSG = "Account error";
  private static let ERROR_CODE = "100";
  
  @objc
  static func requiresMainQueueSetup() ->Bool {
    return false;
  }
  
  static func getAccount(fromJson json: String) -> Account? {
    guard let data = json.data(using: .utf8) else { return nil }
    return try? JSONDecoder().decode(Account.self, from: data)
  }
  
  private func getDIDAccounts() -> [[String: Any]] {
    guard let accounts = (DetectID.sdk() as? DetectID)?.getAccounts() as? [Any] else { return [] }
    return accounts.map({ a -> [String: Any]? in
      do {
        if let account = a as? Account {
          let data = try JSONEncoder().encode(account)
          return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
      } catch {}
      return nil
    }).compactMap({ $0 })
  }
  
  @objc
  func existAccounts(_ callback:@escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async {
      callback(["\((DetectID.sdk() as? DetectID)?.existAccounts() ?? false)"])
    }
  }
  
  @objc
  func getAccounts(_ callback:@escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async {
      callback(["[\(self.getDIDAccounts().map({ $0.toJson() }).joined(separator: ","))]"])
    }
  }
  
  @objc
  func removeAccount(_ accountJson: NSString, resolve:@escaping RCTPromiseResolveBlock, reject:@escaping RCTPromiseRejectBlock) {
    guard ((DetectID.sdk() as? DetectID)?.existAccounts() ?? false),
        let account = AccountModule.getAccount(fromJson: accountJson as String) else {
      reject(AccountModule.ERROR_CODE, AccountModule.ERROR_MSG, nil)
      return
    }
    (DetectID.sdk() as? DetectID)?.remove(account)
    DispatchQueue.main.asyncAfter(deadline: .now() + AccountModule.REFRESH_ACCOUNTS_WAIT_TIME) {
      resolve(nil)
    }
  }
  
  @objc
  func setAccountUsername(_ name: String, accountJson: NSString, resolve:@escaping RCTPromiseResolveBlock, reject:@escaping RCTPromiseRejectBlock) {
    guard ((DetectID.sdk() as? DetectID)?.existAccounts() ?? false),
        let account = AccountModule.getAccount(fromJson: accountJson as String) else {
      reject(AccountModule.ERROR_CODE, AccountModule.ERROR_MSG, nil)
      return
    }
    (DetectID.sdk() as? DetectID)?.setAccountUsername(name, for: account)
    resolve(nil)
  }
  
}
