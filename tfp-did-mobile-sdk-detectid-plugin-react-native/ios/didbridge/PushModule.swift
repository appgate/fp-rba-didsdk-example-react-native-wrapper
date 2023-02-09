//
//  PushModule.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 11/8/22.
//

import Foundation
import didm_sdk

@objc(PushModule)
class PushModule: NSObject {
  
  @objc
  static func requiresMainQueueSetup() ->Bool {
    return false;
  }
  
  @objc
  public func setPushTransactionOpenListener(_ callback: @escaping RCTResponseSenderBlock) {
    DIDSDK.instance.pushTransactionOpenDelegate = TransactionDelegate(callback: callback)
  }
  
  @objc
  public func setPushAlertOpenListener(_ callback: @escaping RCTResponseSenderBlock) {
    DIDSDK.instance.pushAlertOpenDelegate = TransactionDelegate(callback: callback)
  }
  
  @objc
  public func setPushTransactionServerResponseListener(_ callback: @escaping RCTResponseSenderBlock) {
    DIDSDK.instance.pushTransactionServerResponseDelegate = TransactionDelegate(callback: callback)
  }
  
  @objc
  public func confirmPushTransactionAction(_ transaction: String) {
    (DetectID.sdk() as? DetectID)?.getPushApi().confirmPushTransactionAction(TransactionInfoConverter.fromJsonStringToObject(transactionInfo: transaction))
  }
  
  @objc
  public func declinePushTransactionAction(_ transaction: String) {
    (DetectID.sdk() as? DetectID)?.getPushApi().declinePushTransactionAction(TransactionInfoConverter.fromJsonStringToObject(transactionInfo: transaction))
  }
  
  @objc
  public func approvePushAlertAction(_ transaction: String) {
    (DetectID.sdk() as? DetectID)?.getPushApi().approvePushAlertAction(TransactionInfoConverter.fromJsonStringToObject(transactionInfo: transaction))
  }
  
}
