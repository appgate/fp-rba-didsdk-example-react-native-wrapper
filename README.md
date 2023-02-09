<picture style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">
    <source media="(prefers-color-scheme: dark)" srcset="./img/LogoDarkBackground.png">
    <source media="(prefers-color-scheme: light)" srcset="./img/LogoWhiteBackground.png" >
    <img alt="Shows a black logo in light color mode and a white one in dark color mode." src="./img/LogoWhiteBackground.png">
</picture>

# DetectID-SDK: React Native Integration

## Table Of Contents

* [Disclaimer](#disclaimer)
* [Description](#description)
* [Technical Information](#technical-information)
    * [DetectID Mobile SDK version](#detectid-mobile-sdk-version)
    * [iOS](#ios)
    * [Android](#android)
    * [React Native](#react-native)
* [DetectID-SDK Integration](#detectid-sdk-integration)
    * [Preliminary Steps](#preliminary-steps)
        * [Installation yarn](#installation-yarn)
        * [Android development environment](#android-development-environment)
    * [iOS development environment](#ios-development-environment)
* [Create project react native](#create-project-react-native)
    * [More documentation](#more-documentation)
        * [Open project library](#open-project-library)
* [Config project plugin](#config-project-plugin)
    * [Android](#android-1)
    * [iOS](#ios-1)
* [Add tfp-did-mobile-sdk-detectid-plugin-react-native](#add-tfp-did-mobile-sdk-detectid-plugin-react-native)
    * [Install the library](#install-the-library)
    * [Run project REACT-NATIVE](#run-project-react-native)
    * [Troubleshooting](#troubleshooting)
* [Implementation](#implementation)
    * [Integrating push services](#integrating-push-services)
        * [Push notifications set-up](#push-notifications-set-up)
            * [For iOS](#for-ios)
            * [For Android](#for-android)
    * [Device Registration](#device-registration)
        * [Code Registration](#code-registration)
            * [Parameters](#parameters)
            * [Implementation example](#implementation-example)
        * [QR - Code Registration](#qr---code-registration)
            * [Parameters](#parameters-1)
            * [Implementation example](#implementation-example-1)
            * [Error handling with catch for registration using URL and QR methods](#error-handling-with-catch-for-registration-using-url-and-qr-methods)
    * [Account Management](#account-management)
        * [getAccounts](#getaccounts)
            * [Parameters](#parameters-2)
            * [Implementation example](#implementation-example-2)
        * [removeAccount](#removeaccount)
            * [Parameters](#parameters-3)
            * [Implementation example](#implementation-example-3)
        * [setAccountUsername](#setaccountusername)
            * [Parameters](#parameters-4)
            * [Implementation example](#implementation-example-4)
        * [existAccounts](#existaccounts)
            * [Parameters](#parameters-5)
            * [Implementation example](#implementation-example-5)
    * [QR Authentication](#qr-authentication)
        * [qrAuthenticationProcess](#qrauthenticationprocess)
            * [Parameters](#parameters-6)
            * [Implementation example](#implementation-example-6)
    * [OTP](#otp)
        * [updateGlobalConfig](#updateglobalconfig)
            * [Parameters](#parameters-7)
            * [Implementation example](#implementation-example-7)
        * [getTokenValue](#gettokenvalue)
            * [Parameters](#parameters-8)
            * [Implementation example](#implementation-example-8)
        * [getTokenTimeStepValue](#gettokentimestepvalue)
            * [Parameters](#parameters-9)
            * [Implementation example](#implementation-example-9)
        * [getChallengeQuestionOtp](#getchallengequestionotp)
            * [Parameters](#parameters-10)
            * [Implementation example](#implementation-example-10)
    * [Push authentication](#push-authentication)
        * [setPushTransactionOpenListener](#setpushtransactionopenlistener)
            * [Parameters](#parameters-11)
            * [Implementation example](#implementation-example-11)
        * [confirmPushTransactionAction](#confirmpushtransactionaction)
            * [Parameters](#parameters-12)
            * [Implementation example](#implementation-example-12)
        * [declinePushTransactionAction](#declinepushtransactionaction)
            * [Parameters](#parameters-13)
            * [Implementation example](#implementation-example-13)
        * [setPushAlertOpenListener](#setpushalertopenlistener)
            * [Parameters](#parameters-14)
            * [Implementation example](#implementation-example-14)
        * [approvePushAlertAction](#approvepushalertaction)
            * [Parameters](#parameters-15)
            * [Implementation example](#implementation-example-15)

# Disclaimer

MIT License

Copyright (c) 2021 Appgate Cybersecurity, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

<a name="desc"></a>

# Description

This repository is meant to help you understand the implementation of the native libraries of DetectID-SDK using React
Naive. This repository reviews the initialization of the SDK, account registration processes and authentication
services. Notice that all the methods of the SDK are accessed from the *DetectIDCordovaPlugin* class.

<a name="tech-desc"></a>

# Technical Information

The native libraries of DetectID-SDK have the following specifications:

## DetectID Mobile SDK version

- iOS: 9.0
    - didm_sdk.xcframework
    - didm_core.xcframework
    - appgate_sdk.xcframework
    - appgate_core.xcframework

- Android: 9.0
    - didm_sdk-9.0.0.aar
    - appgate_sdk-2.0.0.aar

## iOS

- Compiled SDK base: iOS 16.
- Xcode: 14.1.
- OS versions compatibility: From 11 to 16.
- Programming Language: Objective-C and Swift.

## Android

- API level SDK compiled: 33.
- API level version compatibility: From 23 (Android 6.0 - Marshmallow) to 33 (Android 13).
- Programming Language: Java.
- Dependency: Gson, Dagger 2, Firebase and androidx.security.
- Android Studio: Dolphin | 2021.3.1 Patch 1.

The examples used below are provided using:

## React Native

- Node >= v18.12.0
- React Native >= v0.70

<a name="SDK-int"></a>

# DetectID-SDK Integration

On this section, you can review step by step the integration of the SDK and its features.

[Preliminary steps](#prelim)

<a name="prelim"></a>

## Preliminary Steps

Node & Watchman

```bash
brew install node
brew install watchman
```

### Installation yarn

```bash
npm install --global yarn
```

### Android development environment

1. Download and install Android Studio. While on Android Studio installation wizard, make sure the boxes next to all of
   the following items are checked:

- Android SDK
- Android SDK Platform
- Android Virtual Device

2. Install the Android SDK
3. Configure the `ANDROID_SDK_ROOT` environment variable

```bash
 export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
 export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
 export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
```

4. Install Java jdk Version 11 and configure `JAVA_HOME` environment variable

```bash
 export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home/
```

5. Verify node version min > 18.12.0

```http request 
https://nodejs.org/en/
```

React Native Command Line Interface

If you previously installed a global react-native-cli package, please remove it as it may cause unexpected issues:

```bash
 npm uninstall -g react-native-cli @react-native-community/cli
```

## iOS development environment

`Xcode`

`Command line tools for Xcode`

`Cocoapods`

Download Xcode from App Store, install the Command line tools the first time you open Xcode and install Cocoapods:

```bash
sudo gem install cocoapods
```

# Create project react native

If you're starting a new project, there are a few different ways to get started.

You can use the TypeScript template:

```bash
npx react-native init MyApp --template react-native-template-typescript
```

## More documentation

```http request 
https://reactnative.dev/docs/typescript
```

### Open project library

Compile library

> yarn install

Go to app folder and continue installation

# Config project plugin

Add libraries after creating the project in react native

### Android

Open Android folder to Android Studio

Open Android Studio, click in the button open

![openAndroidStudio1.png](img%2FopenAndroidStudio1.png)

find android folder in the project created

![openAndroidStudio2.png](img%2FopenAndroidStudio2.png)

Wait to sync project

Go to the Android folder, check that the app/libs folder exists, if it doesn't create it, then inside this folder add
libraries arr

1. appgate_sdk-2.0.0.aar
2. didm_sdk-9.x.x.aar

![libsAndroid.png](img%2FlibsAndroid.png)

![libsAndroid2.png](img%2FlibsAndroid2.png)

add implementation lib in app/build.gradle

```
implementation fileTree(include: ['*.aar'], dir: 'libs')
```

### iOS

Copy the DID and Appgate frameworks in the folder `ios/libs` of the library.

Open `ios/DIDReact.xcodeproj` library project and confirm that `DIDReact/libs` has the 4 frameworks.

![iOS-Frameworks.png](img%2FiOS-Frameworks.png)

1. appgate_core.xcframework
2. appgate_sdk.xcframework
3. didm_core.xcframework
4. didm_sdk.xcframework

![EmbedFrameworks.png](img%2FEmbedFrameworks.png)

- Go to General Settings and mark the 4 libraries as **Embed & Sign**.
- Go to Build Settings and in **Build Options** and make sure that "Enable Bitcode" is set to NO.

![DisableBitcode.png](img%2FDisableBitcode.png)

Setting up the required configurations for your App:

Complete the instructions
from [Add tfp-did-mobile-sdk-detectid-plugin-react-native](#add-tfp-did-mobile-sdk-detectid-plugin-react-native) first
and then continue with the following instructions.

At the root of your folder app run `npx pod-install`.

- Open the `.xcworkspace` from your App.
- Go to **Info.plist** and for "App Transport Security Settings" set "Allow Arbitrary Loads" to YES.

# Add tfp-did-mobile-sdk-detectid-plugin-react-native

For a good performance of the library we will only work with 'yarn'.

## Install the library

1. Clean Yarn Cache

```bash
yarn cache clean
```

2. Go to folder library

```bash
cd ../tfp-did-mobile-sdk-detectid-plugin-react-native/
```

3. Compile library

```bash
yarn install
```

4. Go to app folder

```bash
cd ../react-native-didsdk-app/
```

5. Remove previous versions of the library

```bash
yarn remove tfp-did-mobile-sdk-detectid-plugin-react-native
```

6. Add didsdk-library

```bash
yarn add ../tfp-did-mobile-sdk-detectid-plugin-react-native
```

## Run project REACT-NATIVE

Execute command yarn install to install all dependencies to react

```bash
yarn install
```

Run on device or emulator

1. Android

```bash
npx react-native run-android
```

2. iOS

```bash
npx react-native run-ios
```

The first time the Simulator will be opened, but from the second time onwards you can run it from Xcode directly to the
Device.

### Troubleshooting

- Make sure you have a valid certificate and provisioning profile to run the project on a real device.
- The first time you run the project after a `pod install`, you will encountered an error with Pods. Just select a Team
  for the Pods settings and this will fix the bug for the next build.
- Make sure to re-subscribe to both notification listeners every time a push arrives becaues React Native allows a
  single use of each callback.
- The push notifications won't work if the method `DetectIDSDK.sdk().registerForRemoteNotifications()` isn't called from
  the `AppDelegate`. Do not implement this integration by yourself because the token won't be registered within DID
  library.

<a name="int-auth"></a>

# Implementation

The following are the methods that can be implemented with the plugin sdk, in the js part

## Integrating push services

These steps must be completed with platform-specific native code to enable the features that use push notifications such
as Push Authentication and Push Alerts.

<a name="push-auth"></a>

### Push notifications set-up

These feature allows to use push notifications to provide user authentication services, as well as informative push
alerts to relay information to the user.
The methods found below must be implemented only once right after the application has finished loading.

#### For iOS

To enable the use of Push Notifications (Push Authentication, Push Alert) follow these steps:

- Add the Push Notifications Capability.

![PushCapability.png](img%2FPushCapability.png)

- Import the wrapper of DID library in your `AppDelegate` file:

``` 
#import <tfp_did_mobile_sdk_detectid_plugin_react_native/tfp-did-mobile-sdk-detectid-plugin-react-native-umbrella.h>
```

- Implement this function to pass the Token information to the SDK:

```
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:
(NSData*)deviceToken {
  [[DetectIDSDK sdk] receivePushServiceId:deviceToken];
}
```

- From the method `didFinishLaunchingWithOptions` of `AppDelegate` call this function:

``` 
[[DetectIDSDK sdk] registerForRemoteNotifications: launchOptions];
```

This function will trigger the request for Push permission and will handle the receiving of push notifications in the Wrapper.

#### For Android

##### Configure provider for push notification

**On Android, the plugin is compatible with firebase and HUAWEI Mobile Services, for the correct operation it is necessary to configure the service provider which is mentioned in the file [PUSHSERVICE.md](PUSHSERVICE.md)**

1. Request a Token from FirebaseMessaging class n `onCreate` method in your `MainApplication`:

 ``` java
 public class MainApplication extends Application implements ReactApplication {
    	
        @Override
    	public void onCreate() {
            super.onCreate();
		    FirebaseMessaging.getInstance().getToken().addOnCompleteListener(task -> {
            if (!task.isSuccessful()) {
             	return;
            }
	        String token = task.getResult();	    
        });
 }
 ...
 ```

2. Register the Activity Life Cycle Callbacks with the following class `DIDActivityLifecycle` in `onCreate` method in
   your `MainApplication`:

 ```java
 public class MainApplication extends Application implements ReactApplication { 
    	
        @Override
    	public void onCreate() {
            super.onCreate();
		    FirebaseMessaging.getInstance().getToken().addOnCompleteListener(task -> {
            if (!task.isSuccessful()) {
            	return;
            }
	        String token = task.getResult();
		    registerActivityLifecycleCallbacks(new DIDActivityLifecycle());
        });
 }
 ...
 ```

3. In `MainActivity` call `onCreate` method from `MainActivityDelegate` before `super.onCreate(savedInstanceState);` the
   following Method to pass TransactionInfo data to Main ReactComponent through extras in intent passing `ReactActivity:
   
 ``` java
import static com.appgate.plugin.reactnative.util.LogConstants.RN_TRANSACTION_INFO;
import static com.appgate.plugin.reactnative.util.LogConstants.RN_TYPE_PUSH;

 public class MainActivity extends ReactActivity {
 	
    public static class MainActivityDelegate extends ReactActivityDelegate {
		ReactActivity mActivity;
        private Bundle mInitialProps = null;
		
		public MainActivityDelegate(ReactActivity activity, String mainComponentName) {
            super(activity, mainComponentName);
		    mActivity = activity;
        }
	
    	@Override
		protected void onCreate(Bundle savedInstanceState) {
            Bundle extras = mActivity.getIntent().getExtras();
            if (extras != null) {
                String transactionInfo = extras.getString(RN_TRANSACTION_INFO);
                if (extras.containsKey(RN_TYPE_PUSH)) {
                    int tyPush = (int) extras.get(RN_TYPE_PUSH);
                    mInitialProps = new Bundle();
                    mInitialProps.putString(RN_TRANSACTION_INFO, transactionInfo);
                    mInitialProps.putInt(RN_TYPE_PUSH, tyPush);
                }
            }
			super.onCreate(savedInstanceState);
		}
    }

 }

 ```

4. And finally get TransactionInfo Data in `constructor` method from your main `index.tsx`:

 ```
 export default class Index extends React.Component<Props> {
 
	constructor(props: any) {
		if (Platform.OS === 'android') {
	       if (this.props.RNTransactionInfo != undefined) {
        	    this.sendTransaction(this.props.RNTransactionInfo, this.props.RNTypePush);
           }
        }
	}
	
	sendTransaction(transactionInfo: string, type: DIDTypePush) {
		//Set your UI logic here to show a Notification if transactionInfo was received.
	}
 }
 ```

## Device Registration

Once the SDK is initialized, it is necessary to register the device to an existing account in the server to enable all
the services of DetectID. There are 2 ways to complete this procedure:

### Code Registration

This method registers the device through a code sent via e-mail, SMS or a text message.

#### Parameters

* String URL, registration URL + Code sent.
* Promise functions success (`then`) and fail (`catch`).

#### Implementation example

```tsx
import { didRegistration } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

didRegistration(url).then(() => {
  console.log('Register successful!');
}).catch((error: any) => {
  console.log('Registration error!');
  console.log(`${error.code}: ${error.message}`);
});
```

### QR - Code Registration

This method registers the device through a QR code presented through an external channel (web, ATM, etc.).

#### Parameters

* String data, data to read qr.
* Promise functions success (`then`) and fail (`catch`).

#### Implementation example

```tsx
import { didRegistrationByQRCode } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

didRegistrationByQRCode(url).then(() => {
  console.log('Register successful!');
}).catch((err: any) => {
  console.log('Registration error!');
  console.log(`${error.code}: ${error.message}`);
});
```

#### Error handling with `catch` for registration using URL and QR methods

* 400 Empty Parameter
* 500 System Error
* 426 Operating System not supported
* 404 Activation code does not exist
* 410 Activation code has expired
* 417 client has reached maximum number of devices allowed
* 409 The device is already registered

## Account Management

### getAccounts

Allows to retrieve the list of registered accounts.

#### Parameters

* Callback functions return all accounts

#### Implementation example

```tsx
import { getAccounts } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

getAccounts((accounts) => {
  let accountList = JSON.parse(accounts)
  accountList.map((account) => {
    console.log(account);
  });
});
```

### removeAccount

This method can be used to delete an account. This method uses the parameter currentAccount which corresponds to the
account that is about to be erased from the device

#### Parameters

* Account to be erased from the device in string
* Promise functions success (`then`) and fail (`catch`).

#### Implementation example

```tsx
import { removeAccount } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

removeAccount(account).then(() => {

}).catch((error: object) => {
  let err = JSON.parse(JSON.stringify(error));
  console.log(`${err['code']}: ${err['message']}`);
});
```

### setAccountUsername

This method is used to update the username of an account.
This method uses the parameter currentAccount which corresponds to the account that is about to be modified.

#### Parameters

* newUsername new name to user
* Account that is about to be modified in string.

#### Implementation example

```tsx
import { setAccountUsername } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

setAccountUsername(newUsername, account).then((_) => {

}).catch((error: object) => {
  let err = JSON.parse(JSON.stringify(error));
  console.log(`${err['code']}: ${err['message']}`);
});
```

### existAccounts

This method is used to validate exist accounts.

#### Parameters

* Callback functions return boolean is existing

#### Implementation example

```tsx
import { existAccounts } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

existAccounts((hasAccounts) => {
  console.log(hasAccounts);
});
```

## QR Authentication

This method receives the validation account along with the information obtained from the qr code to complete the
authentication process.

### qrAuthenticationProcess

#### Parameters

* Account currentAccount in string
* String data, data to read qr.
* Promise functions success (`then`) and fail (`catch`).

#### Implementation example

```tsx
import { qrAuthenticationProcess } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

qrAuthenticationProcess(account, data).then((transaction) => {

}).catch((error: object) => {
  let err = JSON.parse(JSON.stringify(error));
  console.log(`${err['code']}: ${err['message']}`);
});
```

## OTP

This feature allows to authenticate the user through one-time passwords generated by the SDK inside the secured entity's
mobile application.

### updateGlobalConfig

This method Calls the server to update the lifetime of the token for a specific account.

#### Parameters

* Account currentAccount in string

#### Implementation example

```tsx
import { updateGlobalConfig } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

updateGlobalConfig(account);
```

### getTokenValue

This method returns a string with the value of the token at the time of the query for the specified account.

#### Parameters

* Account currentAccount in string
* Callback functions return token value

#### Implementation example

```tsx
import { getTokenValue } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

getTokenValue(account, (otp) => {
  console.log(otp);
});
```

### getTokenTimeStepValue

Returns an integer value between 0 and 99 indicating the progress of the token progress bar for the specified account.

#### Parameters

* Account currentAccount in string
* Callback functions return integer value

#### Implementation example

```tsx
import { getTokenTimeStepValue } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

getTokenTimeStepValue(account, (time) => {
  console.log(time);
});
```

### getChallengeQuestionOtp

This method returns the OTP associated with the account sent as a parameter and the response to the proposed challenge.

#### Parameters

* Account currentAccount in string
* Answer Response to the challenge presented by the SDK.
* Callback functions return toke value

#### Implementation example

```tsx
import { getChallengeQuestionOtp } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

getChallengeQuestionOtp(account, answer, (otp: string) => {
  console.log(otp);
});
```

## Push authentication

These feature allows to use push notifications to provide user authentication services, as well as informative push
alerts to relay information to the user. The methods found below must be implemented only once right after the
application has finished loading.

### setPushTransactionOpenListener

This listener is executed every time a Push transaction is opened from the Notifications panel; useful when the company
wants to implement any additional functionality when the notification opens.

#### Parameters

* Callback functions return transaction info

#### Implementation example

```tsx
import { setPushTransactionOpenListener } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

setPushTransactionOpenListener(transactionInfo => {
  console.log(transactionInfo);
});
```

Make sure to re-subscribe to the transaction listener after receiving one, because React Native does not support
calling the callbacks or promises more than once.

### confirmPushTransactionAction

Executes the action to confirm the last received transaction; it is useful to implement or control the visualization of
the Push transaction.

#### Parameters

* transaction to confirm push

#### Implementation example

```tsx
import { confirmPushTransactionAction } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

confirmPushTransactionAction(transaction);

```

### declinePushTransactionAction

This method executes the action to decline the received transaction; it is useful to implement or control the
visualization of the Push transaction.

#### Parameters

* transaction to decline push

#### Implementation example

```tsx
import { declinePushTransactionAction } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

declinePushTransactionAction(transaction);
```

### setPushAlertOpenListener

This listener is executed every time a Push alert is opened from the Notifications panel; useful when the company wants
to implement any additional functionality when the notification opens.

#### Parameters

* Callback functions return transaction info

#### Implementation example

```tsx
import { setPushAlertOpenListener } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

setPushAlertOpenListener(transactionInfo => {
  console.log(transactionInfo);
});
```

Make sure to re-subscribe to the transaction listener after receiving one, because React Native does not support
calling the callbacks or promises more than once.

### approvePushAlertAction

This method executes the action to approve the received alert, it is useful to implement or control the Push transaction
visualization. The listener will return a transactionJson object, which will contain the information necessary to handle
one or multiple received alerts.

#### Parameters

* transaction to approve push alert

#### Implementation example

```tsx
import { approvePushAlertAction } from 'tfp-did-mobile-sdk-detectid-plugin-react-native';

approvePushAlertAction(transaction);
```


