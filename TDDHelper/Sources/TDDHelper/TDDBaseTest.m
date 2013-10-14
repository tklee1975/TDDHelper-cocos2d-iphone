#ifdef UNIT_TEST
//	GU (Graphics UnitTest) Library
//
//  BaseTest.m
//  CCTest1
//
//  Created by Ken Lee on 11/9/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "TDDBaseTest.h"
#import "TDDSuiteScene.h"

#define kMenuHeight 20

@implementation TDDBaseTest

- (CGSize) getScreenSize
{
	return [[CCDirector sharedDirector] view].frame.size;
}

- (void) addBackButton
{
	CCLabelTTF *label = [CCLabelTTF labelWithString:@"BACK" fontName:@"Arial" fontSize:20];
	//[label set]
	CCMenuItem *item = [CCMenuItemLabel itemWithLabel:label
											   target:self selector:@selector(backToSuite:)];
	CCMenu *menu = [CCMenu menuWithItems:item, nil];
	
	CGSize screenSize = [self getScreenSize];
	CGPoint pos = ccp(screenSize.width/2, screenSize.height - kMenuHeight);
	
	NSLog(@"debug: addBackButton: pos=%f,%f", pos.x, pos.y);
	
	// [menu setAnchorPoint:ccp(0, 1)];
	[menu setPosition:pos];
	[self addChild:menu];
}

- (void)backToSuite:(id)sender
{
	[[CCDirector sharedDirector] popScene];
}

- (void)setUp
{
	// To be modified
}

- (void)tearDown
{
	// To be modified
}

- (void)onEnter
{
	[super onEnter];
	// clean up the unncessary UIView
	UIView *view = [[CCDirector sharedDirector] view];
	for(UIView *childView in [view subviews]){
		[childView removeFromSuperview];
	}
	CCLOG(@"uiView: %@", view);

	// 
	
	[self setUp];
	

	[self addBackButton];
}

- (void)onExit
{
	[self tearDown];
	
	[super onExit];
}

- (void) setTestSuite:(TDDSuiteScene *)scene
{
	mTestSuiteScene = scene;
}

@end

#endif