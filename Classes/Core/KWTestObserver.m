//
//  Licensed under the terms in License.txt
//
//  Created by Ashton Williams on 8/09/13. https://github.com/Ashton-W
//  Copyright (c) 2013 Allen Ding. All rights reserved.
//

#import "KWTestObserver.h"

NSString * const SenTestObserverClassKey = @"KWTestObserver";

#define XCODE_COLORS_ESCAPE    @"\033["
#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define KW_COLOR_RED   XCODE_COLORS_ESCAPE @"fg163,21,21;"
#define KW_COLOR_GREEN XCODE_COLORS_ESCAPE @"fg0,128,0;"
#define KW_COLOR_BLUE  XCODE_COLORS_ESCAPE @"fg0,0,128;"
#define KW_COLOR_AQUA  XCODE_COLORS_ESCAPE @"fg43,131,159;"


@implementation KWTestObserver

#pragma mark - SenTestObserver

+ (void)testSuiteDidStart:(NSNotification *)aNotification
{
	beginColor(KW_COLOR_AQUA);
	[SenTestLog testSuiteDidStart:aNotification];
	endColor();
}

+ (void)testSuiteDidStop:(NSNotification *)aNotification
{
	if ([aNotification respondsToSelector:@selector(run)] && [aNotification run].hasSucceeded == NO) {
		beginColor(KW_COLOR_RED);
	}
	else {
		beginColor(KW_COLOR_BLUE);
	}
    [SenTestLog testSuiteDidStop:aNotification];
	endColor();
}

+ (void)testCaseDidStart:(NSNotification *)aNotification
{
	beginColor(KW_COLOR_AQUA);
    [SenTestLog testCaseDidStart:aNotification];
	endColor();
}

+ (void)testCaseDidStop:(NSNotification *)aNotification
{
	if ([aNotification respondsToSelector:@selector(run)] && [aNotification run].hasSucceeded == NO) {
		beginColor(KW_COLOR_RED);
	}
	else {
		beginColor(KW_COLOR_GREEN);
	}
	[SenTestLog testCaseDidStop:aNotification];
	endColor();
}

+ (void)testCaseDidFail:(NSNotification *)aNotification
{
	beginColor(KW_COLOR_RED);
    [SenTestLog testCaseDidFail:aNotification];
	endColor();
}

#pragma mark - Functions

static void beginColor(NSString *colorString)
{
	testLog(colorString);
}

static void endColor()
{
	testLog(XCODE_COLORS_RESET);
}

static void testLog(NSString *message)
{
	NSString *line = [NSString stringWithFormat:@"%@", message];
	[(NSFileHandle *)[NSFileHandle fileHandleWithStandardOutput] writeData:[line dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
