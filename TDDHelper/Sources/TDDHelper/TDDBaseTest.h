#ifdef UNIT_TEST
//	GU (Graphics UnitTest) Library
// 
//  BaseTest.h
//  CCTest1
//
//	This a unit test base class that test for GUI
// 
//  Created by Ken Lee on 11/9/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"

@class TDDSuiteScene;

@interface TDDBaseTest : CCScene
{
	TDDSuiteScene *mTestSuiteScene;
}

- (void) setUp;
- (void) tearDown;
- (void) addBackButton;
- (void) backToSuite:(id)sender;
- (void) setTestSuite:(TDDSuiteScene *)scene;
@end
#endif