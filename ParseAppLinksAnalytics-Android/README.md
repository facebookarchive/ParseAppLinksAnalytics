# Parse App Links Analytics

## Overview

This project contains the `ParseAppLinksAnalytics` library that ties Parse Analytics together with App Links event notifications from [Bolts](https://github.com/BoltsFramework/). You can view your app's Parse Analytics dashboard to see how App Links are being used. This includes analyzing outbound and incoming App Links.

Once you've installed the library, you can add the following line in your project to start measuring App Links events:

```java
ParseAppLinksAnalytics.enableTracking(context);
```

Note that these events are only triggered if the App Links are constructed using the [Bolts SDK](https://github.com/BoltsFramework/).

The custom event data you'll see in Parse Analytics correspond to the following:

  + `AppLinksInbound`: your app is opened via an App Links URL.
  + `AppLinksOutbound`: your app navigates to another app via an App Links URL.

## Installation

You can download the latest jar file from our [Releases page](https://github.com/ParsePlatform/ParseAppLinksAnalytics/releases). To install it, simple drag the `ParseAppLinksAnalytics-1.0.0.jar` file (or the latest version) into your project's `lib` folder and set up the dependecies appropriately based on your IDE.

## Customizing Event Names

By default, the custom event names recorded in Parse Analytics are: `AppLinksInbound` and `AppLinksOutbound`. You can modify `ParseAppLinksBroadcastReceiver.java` to customize the event names. Once you've made these changes, you can run the following Gradle command from the repo's android-specific directory to regenerate the library:

```
./gradlew clean jarRelease
```

You'll find the resulting jar file in the `ParseAppLinksAnalytics/build/libs` folder.

## Contributing
See the CONTRIBUTING file for how to help out.

## License
See the LICENSE file for details.