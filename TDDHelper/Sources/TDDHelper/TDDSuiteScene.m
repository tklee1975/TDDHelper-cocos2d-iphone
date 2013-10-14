#ifdef UNIT_TEST
//  TDDSuiteView & TDDSuiteScene
//
//  Created by Ken Lee on 10/9/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "TDDSuiteScene.h"

#define ROW_HEIGHT	50
#define TAG_TEST_SUITE_VIEW	1

#define kFilterButtonWidth 60
#define kTableRowHeight 50
#define kFilterHeight 30

@implementation TDDSuiteView
- (CGSize) getScreenSize
{
	return [[CCDirector sharedDirector] view].frame.size;
}


- (id)initWithFrame:(CGRect)frame testArray:(NSArray *)testArray
{
	self = [super initWithFrame:frame];
	if(self) {
		// setup the data
		mAllTestArray = [[NSMutableArray alloc] initWithArray:testArray];
		mFilterTestArray = [[NSMutableArray alloc] init];
		[self setFilter:@""];
			
		// setup the GUI
		[self createTableView];
		[self createFilterView];
		// NSLog(@"array=%@", mAllTests);
	}
	
	return self;
}

- (void)dealloc
{
	[mAllTestArray release];
	[mFilterTestArray release];
	[super dealloc];
}

- (void) createFilterView
{
	// Two part: input form and button
	int height = kFilterHeight;
	int width = self.frame.size.width;
	int buttonW = kFilterButtonWidth;
	CGRect rect;
	
	rect = CGRectMake(0, 0, width - buttonW, height);
	
	// Text input
	UITextField *textView = [[UITextField alloc] initWithFrame:rect];
	textView.backgroundColor = [UIColor darkGrayColor];
	textView.font = [UIFont fontWithName:@"arial" size:20];
	textView.textColor = [UIColor orangeColor];
	textView.autocapitalizationType = false;
	textView.placeholder = @"Test Name ?";
	[self addSubview:textView];
	[textView release];
	mInput = textView;
	
	// button
	UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	rect = CGRectMake(width - buttonW, 0, buttonW, height);
	button.frame = rect;
	[button addTarget:self action:@selector(filterPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:button];
}

- (void) createTableView
{
	CGRect tableRect = self.frame;
	tableRect.origin.x = 0; tableRect.origin.y = kFilterHeight;
	//NSLog(@"rect=%f,%f", tableRect.size.width, tableRect.size.height);
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:tableRect];
	tableView.rowHeight = ROW_HEIGHT;
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableView.backgroundColor = [UIColor whiteColor];
	tableView.separatorColor = [UIColor colorWithWhite:0 alpha:1];
	
	[self addSubview:tableView];
	mTableView = tableView;
	
	[tableView release];
}

- (void)filterPressed:(id)sender
{
	NSLog(@"filterPressed!");
	NSString *result = mInput.text;
	NSString *trimResult = [result stringByTrimmingCharactersInSet:
							[NSCharacterSet characterSetWithCharactersInString:@" "]];
	NSLog(@"trimResult = [%@]", trimResult);
	[self setFilter:trimResult];
}

- (void)setFilter:(NSString *)filter
{
	[mFilterTestArray removeAllObjects];
	for(NSString *test in mAllTestArray) {
	
		if([filter length] > 0) {
			NSRange range = [test rangeOfString:filter options:NSCaseInsensitiveSearch];
			if(range.length == 0) {
				continue;
			}
		}
		
		[mFilterTestArray addObject:test];
	}
	NSLog(@"mFilter=%@", mFilterTestArray);
	
	[mTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
	return [mFilterTestArray count];
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	static NSString *const identifier = @"TableCell";
	UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:identifier];
	NSInteger row = indexPath.row;
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:identifier] autorelease];
	}
	
	NSLog(@"tableView: at row=%d", row);
	NSString *str = [mFilterTestArray objectAtIndex:row];
	str = [str stringByReplacingOccurrencesOfString:@"Test" withString:@""];
	
	CGSize size = [self getScreenSize];
	CGRect rect = CGRectMake(0, 0, size.width, ROW_HEIGHT);
	UILabel *label = [[UILabel alloc] initWithFrame:rect];
	label.text = [NSString stringWithFormat:@"%@", str];
	[cell addSubview:label];
	[label release];

	return cell;
}


- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath
{
	int index = newIndexPath.row;
	NSLog(@"selected index=%d", index);
	NSString *testName = [mFilterTestArray objectAtIndex:index];
	
	[self runTest:testName];
}

- (void)runTest:(NSString *)test
{
	NSLog(@"Want to test [%@]", test);
	CCScene *testScene = [[NSClassFromString(test) alloc]init];
	if(testScene == nil) {
		NSLog(@"No Scene found for class [%@]", test);
		return;
	}
	
	[[CCDirector sharedDirector] pushScene:testScene];
}

@end


@implementation TDDSuiteScene
-(id) init
{
	self =[super init];
	if(self) {
		NSLog(@"TDDSuiteScene is called");
	}
	
	return self;
}

- (NSArray *)getTests		// this should be override
{
	return [NSArray arrayWithObjects:@"LayerTest", nil];
}

- (void)addSuiteView
{
	if(mSuiteView != nil) {
		return;
	}
	NSArray *testArray = [self getTests];
	
	CGRect rect = [[CCDirector sharedDirector] view].frame;
	NSLog(@"dubg: rect=%f,%f,%f,%f", rect.size.width, rect.size.height, rect.origin.x, rect.origin.y);
	TDDSuiteView *suiteView = [[TDDSuiteView alloc] initWithFrame:rect testArray:testArray];
	suiteView.tag = TAG_TEST_SUITE_VIEW;
	[[[CCDirector sharedDirector] view] addSubview:suiteView];
	[suiteView release];

	mSuiteView = suiteView;
}

- (void)onEnter
{
	[super onEnter];
	NSLog(@"TDDScene re-enter!");
	[self addSuiteView];
}

-(void)onExit
{
	[mSuiteView removeFromSuperview];
	mSuiteView = nil;
	
	[super onExit];
}
@end
#endif