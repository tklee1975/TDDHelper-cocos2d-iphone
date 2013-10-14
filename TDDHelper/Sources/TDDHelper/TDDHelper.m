//
//  TDDHelper.m
//  TDDHelper
//
//  Created by Ken Lee on 14/10/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "TDDHelper.h"

@implementation TDDHelper

+ (void)addTestButton:(CCNode *)parent sceneName:(NSString *)sceneName position:(CGPoint)pos
{
	CCScene *testScene = [[[NSClassFromString(sceneName) alloc]init] autorelease];
	
	if(testScene == nil){
		NSLog(@"addTestButton: testScene is not ready");
		return;
	}
	
	// Achievement Menu Item using blocks
	CCMenuItemFont *menuItem = [CCMenuItemFont itemWithString:@"Test" block:^(id sender) {
		[[CCDirector sharedDirector] replaceScene:testScene];
	}];
	[menuItem setFontName:[TDDHelper getTestBtnFont]];
	[menuItem setFontSize:[TDDHelper getTestBtnSize]];
	
	CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];

	[menu alignItemsHorizontallyWithPadding:0];
	[menu setPosition:pos];
	
	// Add the menu to the layer
	[parent addChild:menu];
}

+ (NSString *)getTestBtnFont
{
	return @"Arial";
}

+ (NSInteger)getTestBtnSize
{
	return 15;
}

@end
