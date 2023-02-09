//
//  TransactionInfoConverter.swift
//  DIDReact
//
//  Created by Daniel Ayala on 31/10/22.
//

import Foundation

struct TransactionInfoConverter {
    private static let transactionID = "transactionID"
    private static let subject = "subject"
    private static let message = "message"
    private static let subjectNotification = "subjectNotification"
    private static let messageNotification = "messageNotification"
    private static let urlToResponse = "urlToResponse"
    private static let transactionOfflineCode = "transactionOfflineCode"
    private static let account = "account"
    private static let timeStamp = "timeStamp"
    private static let type = "type"
    private static let biometricType = "biometricType"
    private static let status = "status"
    
    static func fromObjectToJsonString(transactionInfo: TransactionInfo) -> String? {
        let transactionInfoDictionary = [transactionID : transactionInfo.transactionID ?? "",
                                               subject : transactionInfo.subject ?? "",
                                               message : transactionInfo.message ?? "",
                                   subjectNotification : transactionInfo.subjectNotification ?? "",
                                   messageNotification : transactionInfo.messageNotification ?? "",
                                         urlToResponse : transactionInfo.urlToResponse ?? "",
                                transactionOfflineCode : transactionInfo.transactionOfflineCode ?? 0,
                                               account : CodableConverter.getDictionary(codable: transactionInfo.account) ?? "",
                                             timeStamp : transactionInfo.timeStamp,
                                                  type : String(transactionInfo.type.rawValue),
                                         biometricType : String(transactionInfo.biometricType.rawValue),
                                                status : String(transactionInfo.status.rawValue)] as [String : Any]
        guard let transactionInfoData = try? JSONSerialization.data(withJSONObject: transactionInfoDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return nil
        }
        
        return String(decoding: transactionInfoData, as: UTF8.self)
    }
    
    static func fromJsonStringToObject(transactionInfo: String) -> TransactionInfo? {
        let data = Data(transactionInfo.utf8)
        guard let transactionInfoDictionary = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String, Any> else {
            return nil
        }
        
        let transactionInfo = TransactionInfo()
        transactionInfo.transactionID = transactionInfoDictionary[transactionID] as? String
        transactionInfo.subject = transactionInfoDictionary[subject] as? String
        transactionInfo.message = transactionInfoDictionary[message] as? String
        transactionInfo.subjectNotification = transactionInfoDictionary[subjectNotification] as? String
        transactionInfo.messageNotification = transactionInfoDictionary[messageNotification] as? String
        transactionInfo.urlToResponse = transactionInfoDictionary[urlToResponse] as? String
        transactionInfo.transactionOfflineCode = transactionInfoDictionary[transactionOfflineCode] as? String
        transactionInfo.timeStamp = transactionInfoDictionary[timeStamp] as! Int64
        transactionInfo.account =  try? CodableConverter.getCodable(jsonDictionary: transactionInfoDictionary[account] as! Dictionary<String, Any>) as Account
        transactionInfo.type = TransactionType(rawValue: Int(transactionInfoDictionary[type] as! String) ?? 0)!
        transactionInfo.biometricType = BiometricTransactionType(rawValue: Int(transactionInfoDictionary[biometricType] as! String) ?? 0)!
        transactionInfo.status = TransactionStatus(rawValue: Int(transactionInfoDictionary[status] as! String) ?? 0)!
        
        return transactionInfo
    }
}
