import { NativeModules } from 'react-native';

const { DIDModule, OtpModule, AccountModule, QrModule, PushModule } =
  NativeModules;

export function updateGlobalConfig(account: any) {
  DIDModule.updateGlobalConfig(JSON.stringify(account));
}

export function didRegistration(url: string): Promise<any> {
  return DIDModule.didRegistration(url)
    .then(() => {
      return Promise.resolve();
    })
    .catch((error: any) => {
      let err = JSON.parse(JSON.stringify(error));
      return Promise.reject(err);
    });
}

export function didRegistrationByQRCode(data: string): Promise<any> {
  return DIDModule.didRegistrationByQRCode(data)
    .then(() => {
      return Promise.resolve();
    })
    .catch((error: any) => {
      let err = JSON.parse(JSON.stringify(error));
      return Promise.reject(err);
    });
}

export function isValidPayload(
  data: Map<string, string>,
  callback: (isValid: boolean) => void
) {
  return DIDModule.isValidPayload(data, callback);
}

export function subscribePayload(data: Map<string, string>) {
  DIDModule.subscribePayload(data);
}

export function receivePushServiceId(data: string) {
  DIDModule.receivePushServiceId(data);
}

export function setApplicationName(data: string) {
  DIDModule.setApplicationName(data);
}

export function getDeviceID(callback: (data: string) => void) {
  return DIDModule.getDeviceID(callback);
}

export function getMaskedAppInstanceID(callback: (data: string) => void) {
  return DIDModule.getMaskedAppInstanceID(callback);
}

export function getMobileID(callback: (data: string) => void) {
  return DIDModule.getMobileID(callback);
}

export function setPushTransactionOpenListener(
  callback: (error: Error | null, transactionInfo: any | null) => void
) {
  PushModule.setPushTransactionOpenListener((transactionInfo: string) => {
    try {
      const parsedTransactionInfo = JSON.parse(transactionInfo);
      return callback(null, parsedTransactionInfo);
    } catch (errorCatch: any) {
      return callback(errorCatch, null);
    }
  });
}

export function setPushAlertOpenListener(
  callback: (error: Error | null, transactionInfo: any | null) => void
) {
  PushModule.setPushAlertOpenListener((transactionInfo: string) => {
    try {
      const parsedTransactionInfo = JSON.parse(transactionInfo);
      return callback(null, parsedTransactionInfo);
    } catch (errorCatch: any) {
      return callback(errorCatch, null);
    }
  });
}

export function setPushTransactionServerResponseListener(
  callback: (response: string) => void
) {
  PushModule.setPushTransactionServerResponseListener(callback);
}

export function confirmPushTransactionAction(data: any) {
  PushModule.confirmPushTransactionAction(JSON.stringify(data));
}

export function declinePushTransactionAction(data: any) {
  PushModule.declinePushTransactionAction(JSON.stringify(data));
}

export function approvePushAlertAction(data: any) {
  PushModule.approvePushAlertAction(JSON.stringify(data));
}

export function getAccounts(
  callback: (error: Error | null, accounts: Array<any> | null) => void
) {
  AccountModule.getAccounts((accounts: string) => {
    try {
      const parsedAccounts = JSON.parse(accounts);
      return callback(null, parsedAccounts);
    } catch (errorCatch: any) {
      return callback(errorCatch, null);
    }
  });
}

export function existAccounts(
  callback: (error: Error | null, hasExistAccounts: boolean | null) => void
) {
  AccountModule.existAccounts((hasExistAccounts: string) => {
    try {
      const parsed = JSON.parse(hasExistAccounts);
      return callback(null, parsed);
    } catch (errorCatch: any) {
      return callback(errorCatch, null);
    }
  });
}

export function removeAccount(account: any): Promise<any> {
  return AccountModule.removeAccount(JSON.stringify(account))
    .then(() => {
      return Promise.resolve();
    })
    .catch((error: any) => {
      let err = JSON.parse(JSON.stringify(error));
      return Promise.reject(err);
    });
}

export function setAccountUsername(name: string, account: any): Promise<any> {
  return AccountModule.setAccountUsername(name, JSON.stringify(account))
    .then(() => {
      return Promise.resolve();
    })
    .catch((error: any) => {
      let err = JSON.parse(JSON.stringify(error));
      return Promise.reject(err);
    });
}

export function getTokenValue(account: any, callback: (otp: any) => void) {
  return OtpModule.getTokenValue(JSON.stringify(account), callback);
}

export function getTokenTimeStepValue(
  account: any,
  callback: (percentage: any) => void
) {
  return OtpModule.getTokenTimeStepValue(JSON.stringify(account), callback);
}

export function getChallengeQuestionOtp(
  account: any,
  answer: string,
  callback: (otp: string) => void
) {
  return OtpModule.getChallengeQuestionOtp(
    JSON.stringify(account),
    answer,
    callback
  );
}

export function qrAuthenticationProcess(
  account: any,
  data: string
): Promise<any> {
  return QrModule.qrAuthenticationProcess(JSON.stringify(account), data)
    .then((transactionInfo: any) => {
      return Promise.resolve(JSON.parse(transactionInfo));
    })
    .catch((error: any) => {
      let err = JSON.parse(JSON.stringify(error));
      return Promise.reject(err);
    });
}

export function confirmQRCodeTransactionAction(data: any,
callback: (data: string) => void
) {
  return QrModule.confirmQRCodeTransactionAction(JSON.stringify(data), callback);
}

export function declineQRCodeTransactionAction(data: any,
  callback: (data: string) => void
) {
  return QrModule.declineQRCodeTransactionAction(JSON.stringify(data), callback);
}
