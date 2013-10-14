//
//  MainTestScene.m
//  TDDHelper
//
//  Created by Ken Lee on 14/10/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import "MainTestScene.h"

@implementation MainTestScene
- (NSArray *)getTests       // this should be override
{
	// Return the list of Testing Class
	return [NSArray arrayWithObjects:
            @"SimpleTest",
            @"SimpleDataTest",
            nil];
}

@end
