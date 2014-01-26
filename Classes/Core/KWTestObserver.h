//
//  Licensed under the terms in License.txt
//
//  Created by Ashton Williams on 8/09/13. https://github.com/Ashton-W
//  Copyright (c) 2013 Allen Ding. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface KWTestObserver : SenTestObserver

+ (void)testSuiteDidStart:(NSNotification *)aNotification;
+ (void)testSuiteDidStop:(NSNotification *)aNotification;

+ (void)testCaseDidStart:(NSNotification *)aNotification;
+ (void)testCaseDidStop:(NSNotification *)aNotification;

+ (void)testCaseDidFail:(NSNotification *)aNotification;

@end
