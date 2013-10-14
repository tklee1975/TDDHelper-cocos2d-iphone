#ifdef UNIT_TEST
//
//  GUBaseDataTest.m
//  gg
//
//  Created by Ken Lee on 14/9/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "TDDBaseDataTest.h"

#define HEADING_H 30

@implementation TDDBaseDataTest

- (id)init
{
	self = [super init];
	if(self) {
		mTestcaseArray = [[NSMutableArray alloc] init];
		[self setupTestArray:mTestcaseArray];
		
		mTableView = nil;
	}
	
	return self;
}

- (void)setUp
{
	[self addTableView];
}

- (void)tearDown
{
	[self removeTableView];
}

-(void)setupTestArray:(NSMutableArray *)testArray
{
	
}


- (void)addTableView
{
	if(mTableView != nil)
	{
		return;
	}
	
	CGSize size = [[CCDirector sharedDirector] view].frame.size;
	int width = size.width;
	int height = size.height;
	

	
	// Selection
	CGRect rect = CGRectMake(0, HEADING_H, width, height-HEADING_H);
	UITableView *tableView = [[UITableView alloc] initWithFrame:rect
														  style:UITableViewStylePlain];
	
	[tableView setContentSize:rect.size];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableView.backgroundColor = [UIColor whiteColor];
	tableView.separatorColor = [UIColor grayColor];
	[[[CCDirector sharedDirector] view] addSubview:tableView];
	[tableView release];

	mTableView= tableView;
}

- (void)removeTableView
{
	if(mTableView) {
		[mTableView removeFromSuperview];
	}
}

#pragma mark -
#pragma mark Do Test
-(BOOL)doTest:(NSString *)testName
{
	
	SEL testSelector = NSSelectorFromString(testName);
	if([self respondsToSelector:testSelector] == NO){
		NSLog(@"runAllTest: no selector for %@", testName);
		return NO;
	}
	[self performSelector:testSelector];
	
	return YES;
}

#pragma mark -
#pragma mark TableView delegate
- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
	return [mTestcaseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *testMethodName = [mTestcaseArray objectAtIndex:indexPath.row];
	NSString *testName = [testMethodName stringByReplacingOccurrencesOfString:@"test"
																   withString:@""];
	
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	
	UITableViewCell *cell = [[[UITableViewCell alloc]
							  initWithStyle:style reuseIdentifier:@"-"] autorelease];
	cell.textLabel.text = testName;
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	// cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	cell.textLabel.numberOfLines = 10; // It doesn't matter if it is larger than what we need
	return cell;
}

- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath
{
	NSString *testName = [mTestcaseArray objectAtIndex:newIndexPath.row];
	NSLog(@"testName: %@", testName);
	
	[self doTest:testName];
}

@end

#endif