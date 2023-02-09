//
//  OtpModule.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 10/11/22.
//

import Foundation
import didm_sdk

@objc(OtpModule)
class OtpModule: NSObject {
  
  @objc
  static func requiresMainQueueSetup() ->Bool {
    return false;
  }
  
  @objc
  public func getTokenValue(_ accountJson: String, callback: RCTResponseSenderBlock) {
    guard let account = AccountModule.getAccount(fromJson: accountJson as String) else {
      callback([""])
      return
    }
    callback([(DetectID.sdk() as? DetectID)?.getOtpApi().getTokenValue(account) ?? ""])
  }
  
  @objc
  public func getTokenTimeStepValue(_ accountJson: String, callback: RCTResponseSenderBlock) {
    guard let account = AccountModule.getAccount(fromJson: accountJson as String) else {
      callback([""])
      return
    }
    callback(["\((DetectID.sdk() as? DetectID)?.getOtpApi().getTokenTimeStepValue(account) ?? 0)"])
  }
  
  @objc
  public func getChallengeQuestionOtp(_ accountJson: String, answer: String, callback: RCTResponseSenderBlock) {
    guard let account = AccountModule.getAccount(fromJson: accountJson as String), !answer.isEmpty else {
      callback([""])
      return
    }
    callback(["\((DetectID.sdk() as? DetectID)?.getOtpApi().getChallengeQuestionOtp(with: account, answer: answer) ?? "")"])
  }
  
}
