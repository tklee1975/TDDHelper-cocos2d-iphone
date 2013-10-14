#ifdef UNIT_TEST

//  TDDSuiteScene
//  CCTest1
//
//	This has the class to make the TestSuite View and Scene
//
//  Created by Ken Lee on 10/9/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface TDDSuiteView : UIView <UITableViewDataSource, UITableViewDelegate>
{
	UITableView *mTableView;
	NSMutableArray *mFilterTestArray;
	NSMutableArray *mAllTestArray;
	UITextField *mInput;
}

- (id)initWithFrame:(CGRect)frame testArray:(NSArray *)testArray;
- (void)createTableView;
- (void)setFilter:(NSString *)filter;
- (void)runTest:(NSString *)test;

// @property (nonatomic, retain) NSMutableArray *mAllTests;

@end


@interface TDDSuiteScene : CCScene
{
	TDDSuiteView *mSuiteView;
}

- (NSArray *)getTests;		// this should be override
- (void)addSuiteView;
@end

#endif

