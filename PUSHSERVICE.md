<picture style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">
    <source media="(prefers-color-scheme: dark)" srcset="./img/LogoDarkBackground.png">
    <source media="(prefers-color-scheme: light)" srcset="./img/LogoWhiteBackground.png" >
    <img alt="Shows a black logo in light color mode and a white one in dark color mode." src="./img/LogoWhiteBackground.png">
</picture>

* [DetectID-SDK: React Native - Integration Push Services](#detectid-sdk--react-native---integration-push-services)
  * [How is it implemented?](#how-is-it-implemented)
    * [Creation of a Firebase Project to receive Push notifications](#creation-of-a-firebase-project-to-receive-push-notifications)
      * [Importing dependencies on android application](#importing-dependencies-on-android-application)
      * [Declaring activities - Android](#declaring-activities---android)
      * [Declaring services and receivers for Firebase](#declaring-services-and-receivers-for-firebase)
      * [Include the following lines in AndroidManifest.xml](#include-the-following-lines-in-androidmanifestxml)
        * [Declaring MessagingService](#declaring-messagingservice)
    * [Creation of a Huawei Mobile Services (HMS) Push Kit Project to receive Push notifications](#creation-of-a-huawei-mobile-services--hms--push-kit-project-to-receive-push-notifications)
      * [Importing dependencies](#importing-dependencies)
      * [Configuring the manifest](#configuring-the-manifest)
      * [Declaring activities](#declaring-activities)
      * [Declaring services and receivers for HMS](#declaring-services-and-receivers-for-hms)
      * [Include the following lines in AndroidManifest.xml](#include-the-following-lines-in-androidmanifestxml-1)
        * [Declaring MessagingService](#declaring-messagingservice-1)


# DetectID-SDK: React Native - Integration Push Services

DetectID SDK offers a push authentication service that sends a push message to the user via Firebase or Huawei Mobile
Services. This push message allows the user to either accept or cancel transactions through the user’s mobile device.
This push message is sent by the server through a push messaging channel and received by the SDK inside the app. This
means that to accept a transaction, it would be necessary to have both the user’s static PIN or password and the user’s
unlocked device with the app.

`Warning`, this is an integration which is necessary to modify files into the folder /android of the project.

1. Go to the Android folder
2. Choose one of the 2 notification
   providers [HMS](#creation-of-a-huawei-mobile-services--hms--push-kit-project-to-receive-push-notifications)
   or [Firebase](#creation-of-a-firebase-project-to-receive-push-notifications).
3. Follow the indicated steps

## How is it implemented?

To implement DetectID’s push authentication feature in the banking app, it is necessary to create a Firebase or HMS
project. After that procedure has been completed, the authentication service can be implemented in the app.

### Creation of a Firebase Project to receive Push notifications

To use this SDK with the Google notifications messaging service, it is necessary to create a Firebase project. In this
platform you can create a new project to obtain the ServerKey, which is a Push notifications configuration parameter in
the server of DetectID and the file `google-services.json` is required by the function of the Push messaging
services in the SDK. To create a Google Firebase project aiming to obtain the ServerKey parameters, and the
`google-services.json` file, follow the next steps:

1. Create or import the account at `firebase.google.com`.
2. Once done this process, open Google Firebase console.
3. Create the API project in the option Create New Project.

![Firebase1.png](img%2FFirebase1.png)

4. Go to Project settings.

![Firebase2.png](img%2FFirebase2.png)

5. In the General Settings section, enable Firebase for the Android project by adding a new Android application.

![Firebase3.png](img%2FFirebase3.png)

6. Register Android application with your package name

![Firebase4.png](img%2FFirebase4.png)

7. Download `google-services.json` configuration file and include it to the Android Project as it was indicated in the
   Firebase tutorial.

![Firebase5.png](img%2FFirebase5.png)

#### Importing dependencies on android application

`Warning`: Notice that performing this procedure, it is required to have previously carried out the steps corresponding
to
the section Creation of a Firebase Project to receive Push notifications.

1. Add the dependencies to the Android Project to enable the notification services as it was indicated in the Firebase
   tutorial.

![Firebase6.png](img%2FFirebase6.png)

![Firebase7.png](img%2FFirebase7.png)

2. Select Cloud Messaging API (Legacy) tab where Token will be shown.

![Firebase8.png](img%2FFirebase8.png)

#### Declaring activities - Android

The next step is to go to the file `android/src/main/AndroidManifest.xml`, in which we will modify its content by adding
the following lines, which tells us to declare the sdk activities that are in charge of loading and processing the push
information, which will be shown in the notification bar

```xml
<!-- Push Activities -->
<activity android:name="com.appgate.didm_auth.push_auth.transaction.PushTransactionActivity" android:exported="false"
          android:theme="@android:style/Theme.Dialog"/>
<activity android:name="com.appgate.didm_auth.push_auth.alert.PushAlertActivity" android:exported="false"
          android:theme="@android:style/Theme.Dialog"/>
```

#### Declaring services and receivers for Firebase

The SDK needs to know about the creation and updating of the registry token. To carry that out, it is necessary to
create a service that oversees the firebase event that is triggered when the token is created or updated. This can be
achieved through the implementation of a service that extends `com.google.firebase.messaging.FirebaseMessagingService`,
it is necessary to declare the AppgateMessagingModule class, which is in charge of updating the information from the
wrapper to the sdk,this is indispensable for a correct operation, create in android/src/main/java/your.package/.

```java


import androidx.annotation.NonNull;
import com.appgate.plugin.reactnative.sdk.AppgateMessagingModule;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.util.Map;

public class FirebaseMessagingServiceImpl extends FirebaseMessagingService {

    AppgateMessagingModule appgateMessagingModule = new AppgateMessagingModule();

    @Override
    public void onNewToken(@NonNull String token) {
        super.onNewToken(token);
        appgateMessagingModule.onNewTokenFcm(getApplicationContext(), token);
    }

    @Override
    public void onMessageReceived(@NonNull RemoteMessage message) {
        super.onMessageReceived(message);
        Map<String, String> data = message.getData();
        appgateMessagingModule.onMessageReceived(getApplicationContext(), data);        
    }
}
```

#### Include the following lines in AndroidManifest.xml

Go back to the `android/src/main/AndroidManifest.xml` file, in which we will add content, in this element it is
necessary to declare the services and receiver that will give us the possibility to receive notifications when we are
running, when we are paused and when we are in the background.

##### Declaring MessagingService

```xml

<service android:name="your.package.name.FirebaseMessagingServiceImpl" android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"
        />
    </intent-filter>
</service>
<receiver android:name="com.appgate.didm_auth.push_auth.transaction.broadcast.ConfirmPushTransactionBroadcast"
          android:exported="false"/>
<receiver android:name="com.appgate.didm_auth.push_auth.transaction.broadcast.DeclinePushTransactionBroadcast"
          android:exported="false"/>
```

### Creation of a Huawei Mobile Services (HMS) Push Kit Project to receive Push notifications

To use this SDK with the Huawei notifications messaging service, it is necessary to create an HMS project. In this
platform you can create a new project to obtain the ServerKey, which is a Push notifications configuration parameter in
the server of DetectID and the file `agconnect-services.json.` is required by the function of the Push messaging
services in the SDK. To create a Huawei HMS project aiming to obtain the ServerKey parameters, and the
`agconnect-services.json` file, follow the next steps:

1. Create or import the account
   at [https://developer.huawei.com/consumer/en/console#/serviceCards/](https://developer.huawei.com/consumer/en/console#/serviceCards/)
2. Once done this process, open the AppGallery Connect console.
3. Create the API project in the option called My projects > Add project.

![HMS1.png](img%2FHMS1.png)

4. Proceed to the project configuration section

![HMS2.png](img%2FHMS2.png)

5. Perform the process to register the application

![HMS3.png](img%2FHMS3.png)

6. Download `agconnect-services.json` configuration file and include it to the Android Project as it was indicated in
   the HMS tutorial.

![HMS4.png](img%2FHMS4.png)

#### Importing dependencies

`Warning`: Notice that performing this procedure, it is required to have previously carried out the steps corresponding
to the section Creation of a Huawei Mobile Services Push Kit Project to receive Push notifications.

1. Add the dependencies to the Android Project to enable the notification services as it was indicated in the HMS
   tutorial.

![HMS5.png](img%2FHMS5.png)

2. Enable Push Kit in the configuration section named Manage APIs.

![HMS6.png](img%2FHMS6.png)

![HMS7.png](img%2FHMS7.png)

3. At the configuration section, select General Information where ClientID and Client Secret will be shown. Copy it to
   include it in the configuration of the DetectID administration console.

![HMS8.png](img%2FHMS8.png)

#### Configuring the manifest

#### Declaring activities

The next step is to go to the file `android/src/main/AndroidManifest.xml`, in which we will modify its content by
adding
the following lines, which tells us to declare the sdk activities that are in charge of loading and processing the push
information, which will be shown in the notification bar

```xml
<!-- Push Activities -->
<activity android:name="com.appgate.didm_auth.push_auth.transaction.PushTransactionActivity" android:exported="false"
          android:theme="@android:style/Theme.Dialog"/>
<activity android:name="com.appgate.didm_auth.push_auth.alert.PushAlertActivity" android:exported="false"
          android:theme="@android:style/Theme.Dialog"/>
```

#### Declaring services and receivers for HMS

The SDK needs to know about the creation and updating of the registry token. To carry that out, it is necessary to
create a service that oversees the HMS event that is triggered when the token is created or updated. This can be
achieved through the implementation of a service that extends `com.huawei.hms.push.HmsMessageService`,
it is necessary to declare the AppgateMessagingModule class, which is in charge of updating the information from the
wrapper to the sdk,this is indispensable for a correct operation, create in android/src/main/java/your.package/.

```java
import com.appgate.plugin.reactnative.sdk.AppgateMessagingModule;
import com.huawei.hms.push.HmsMessageService;
import com.huawei.hms.push.RemoteMessage;

import java.util.Map;

public class HmsMessageServiceImpl extends HmsMessageService {

    AppgateMessagingModule appgateMessagingModule = new AppgateMessagingModule();

    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        Map<String, String> data = message.getDataOfMap();
        appgateMessagingModule.onNewTokenHms(getApplicationContext(), token);
    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        Map<String, String> data = remoteMessage.getDataOfMap();
        appgateMessagingModule.onMessageReceived(getApplicationContext(), data);        
    }
}

```

#### Include the following lines in AndroidManifest.xml

Go back to the `android/src/main/AndroidManifest.xml` file, in which we will add content, in this element it is
necessary to declare the services and receiver that will give us the possibility to receive notifications when we are
running, when we are paused and when we are in the background.

##### Declaring MessagingService

```xml

<service android:name="your.package.name.HmsMessageServiceImpl" android:exported="false">
    <intent-filter>
        <action android:name="com.huawei.push.action.MESSAGING_EVENT"/>
    </intent-filter>
</service>
<receiver android:name="com.appgate.didm_auth.push_auth.transaction.broadcast.ConfirmPushTransactionBroadcast"
          android:exported="false"/>
<receiver android:name="com.appgate.didm_auth.push_auth.transaction.broadcast.DeclinePushTransactionBroadcast"
          android:exported="false"/>
```
