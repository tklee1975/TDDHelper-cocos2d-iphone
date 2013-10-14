//
//  SimpleDataTest.m
//  TDDHelper
//
//  Created by Ken Lee on 14/10/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "SimpleDataTest.h"
#import "cocos2d.h"
#import <UIKit/UIKit.h>

@implementation SimpleDataTest

- (NSString *)rectToString:(CGRect)rect
{
	return [NSString stringWithFormat:@"%f,%f,%f,%f)",
							rect.origin.x, rect.origin.y,
							rect.size.width, rect.size.height];
			
}

- (void)setupTestArray:(NSMutableArray *)testArray
{
	[testArray addObject:@"testGetBound"];
	[testArray addObject:@"testAppFrame"];
}

- (void)testGetBound
{
	CGRect bounds = [[UIScreen mainScreen] bounds];
	NSLog(@"bound=%@", [self rectToString:bounds]);
}

- (void)testAppFrame
{
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	NSLog(@"appFrame=%@", [self rectToString:appFrame]);
}


@end
