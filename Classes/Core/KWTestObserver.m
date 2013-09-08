//
//  KWTestObserver.m
//  Kiwi
//
//  Created by Ashton Williams on 8/09/13.
//  Copyright (c) 2013 Allen Ding. All rights reserved.
//

#import "KWTestObserver.h"

NSString * const SenTestObserverClassKey = @"KWTestObserver";

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define CXCODE_COLORS_ESCAPE "\033["

#define CXCODE_COLORS_RESET_FG  CXCODE_COLORS_ESCAPE "fg;" // Clear any foreground color
#define CXCODE_COLORS_RESET_BG  CXCODE_COLORS_ESCAPE "bg;" // Clear any background color
#define CXCODE_COLORS_RESET     CXCODE_COLORS_ESCAPE ";"   // Clear any foreground or background color

@implementation KWTestObserver

#pragma mark - Notifications

+ (void) testSuiteDidStart:(NSNotification *)aNotification
{
	[SenTestLog testCaseDidStop:aNotification];
}

+ (void) testSuiteDidStop:(NSNotification *)aNotification
{
    [SenTestLog testCaseDidStop:aNotification];
}

+ (void) testCaseDidStart:(NSNotification *)aNotification
{
    [SenTestLog testCaseDidStop:aNotification];
}

+ (void) testCaseDidStop:(NSNotification *)aNotification
{
	testLog(XCODE_COLORS_ESCAPE @"fg0,0,255;");
	[SenTestLog testCaseDidStop:aNotification];
	testLog(XCODE_COLORS_RESET);
}

+ (void) testCaseDidFail:(NSNotification *)aNotification
{
	testLog(XCODE_COLORS_ESCAPE @"fg255,0,0;");
    [SenTestLog testCaseDidFail:aNotification];
	testLog(XCODE_COLORS_RESET);
}

static void testLog (NSString *message)
{
	NSString *line = [NSString stringWithFormat:@"%@\n", message];
	[(NSFileHandle *)[NSFileHandle fileHandleWithStandardOutput] writeData:[line dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
