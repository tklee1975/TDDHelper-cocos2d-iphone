#ifdef UNIT_TEST
//
//  GUBaseDataTest.h
//  gg
//
//  This a unit test base class that mainly testing for the data
//
//  Created by Ken Lee on 14/9/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "TDDBaseTest.h"
#import <Foundation/Foundation.h>


@interface TDDBaseDataTest : TDDBaseTest <UITableViewDataSource, UITableViewDelegate>
{
	NSMutableArray *mTestcaseArray;		// the testcase show on the tableView
	UITableView *mTableView;
}

@end

#endif