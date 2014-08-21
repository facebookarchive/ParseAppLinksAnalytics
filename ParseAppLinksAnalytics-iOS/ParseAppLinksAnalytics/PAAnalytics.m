/**
* Copyright (c) 2014, Parse, LLC. All rights reserved.
*
* You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
* copy, modify, and distribute this software in source code or binary form for use
* in connection with the web services and APIs provided by Parse.

* As with any software that integrates with the Parse platform, your use of
* this software is subject to the Parse Terms of Service
* [https://www.parse.com/about/terms]. This copyright notice shall be
* included in all copies or substantial portions of the software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
* FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
* IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
*/

#import "PAAnalytics.h"

#import <Parse/Parse.h>

#import "PAConstants.h"

@implementation PAAnalytics

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:PABoltsMeasurementEventNotication
                                                   object:nil];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSDictionary *)eventNameMappingDictionary {
    static NSDictionary *dictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dictionary = @{@"al_nav_in": @"AppLinksInbound",
                       @"al_nav_out": @"AppLinksOutbound",
                       @"al_ref_back_out": @"AppLinksReturning"};
    });
    return dictionary;
}

+ (void)enableTracking {
    // Initialize
    [[self class] sharedInstance];
}

- (void)handleNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *eventName = userInfo[PABoltsMeasurementEventNameKey];
    if (eventName) {
        // If a supported event, track it on Parse as a custom event
        NSString *mappedEventName = [[self class] eventNameMappingDictionary][eventName];
        if (mappedEventName) {
            [PFAnalytics trackEvent:mappedEventName
                         dimensions:userInfo[PABoltsMeasurementEventArgsKey]];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:PABoltsMeasurementEventNotication
                                                  object:nil];
}

@end
