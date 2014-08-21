# Parse App Links Analytics

## Overview

This project contains the `ParseAppLinksAnalytics` library that ties Parse Analytics together with App Links event notifications from [Bolts](https://github.com/BoltsFramework/). You can view your app's Parse Analytics dashboard to see how App Links are being used. This includes analyzing outbound App Links, incoming App Links, as well as seeing which apps have a return link back to your app.

Once you've installed the library, you can add the following line in your project to start measuring App Links events:

```objective-c
[PAAnalytics enableTracking];
```

Note that these events are only triggered if the App Links are processed using the [Bolts SDK](https://github.com/BoltsFramework/).

The custom event data you'll see in Parse Analytics correspond to the following:

  + `AppLinksInbound`: your app is opened via an App Links URL.
  + `AppLinksOutbound`: your app navigates to another app via an App Links URL.
  + `AppLinksReturning`: your app navigates back to the referring app via the return App Links URL.

## Installation

You can download the latest framework files from our [Releases page](https://github.com/ParsePlatform/ParseAppLinksAnalytics/releases). To install it, simple drag the `ParseAppLinksAnalytics.framework` file into your Xcode project's framework list.

## Customizing Event Names

By default, the custom event names recorded in Parse Analytics are: `AppLinksInbound`, `AppLinksOutbound`, and `AppLinksReturning`. You can modify `PAAnalytics.m` to customize the event names. Once you've made these changes, run the build script in the `Scripts` folder to regenerate the framework.

## Contributing
See the CONTRIBUTING file for how to help out.

## License
See the LICENSE file for details.
