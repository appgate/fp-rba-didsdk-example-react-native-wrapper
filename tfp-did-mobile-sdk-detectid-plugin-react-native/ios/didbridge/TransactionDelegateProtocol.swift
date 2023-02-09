//
//  TransactionDelegateProtocol.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 11/10/22.
//

import Foundation
import didm_sdk

protocol TransactionDelegateProtocol {
  
  func onReceived(transaction: TransactionInfo)
  func onReceived(string: String)
}

@objcMembers
public class TransactionDelegate: TransactionDelegateProtocol {
  
  var callback: RCTResponseSenderBlock?
  
  init(callback: @escaping RCTResponseSenderBlock) {
    self.callback = callback
  }
  
  func onReceived(transaction: TransactionInfo) {
    callback?([TransactionInfoConverter.fromObjectToJsonString(transactionInfo: transaction) ?? ""])
    callback = nil
  }
  
  func onReceived(string: String) {
    callback?([string])
    callback = nil
  }
  
}
