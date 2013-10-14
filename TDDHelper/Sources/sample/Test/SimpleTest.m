//
//  SimpleTest.m
//  TDDHelper
//
//  Created by Ken Lee on 14/10/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "SimpleTest.h"
#import "cocos2d.h"

@implementation SimpleTest

- (void) setUp
{
	CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello TDD!" fontName:@"arial" fontSize:30.f];
	
	CGSize size = [[CCDirector sharedDirector] view].frame.size;
	
	label.position = ccp(size.width / 2, size.height / 2);
	
	[self addChild:label];
	
	// self.boundingBox
}

@end
