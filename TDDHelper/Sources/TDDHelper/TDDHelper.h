//
//  TDDHelper.h
//  TDDHelper
//
//  Created by Ken Lee on 14/10/13.
//  Copyright (c) 2013 Ken Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TDDSuiteScene.h"

@interface TDDHelper : NSObject
{
	
}

+ (NSString *)getTestBtnFont;
+ (NSInteger)getTestBtnSize;
+ (void)addTestButton:(CCNode *)parent sceneName:(NSString *)sceneName position:(CGPoint)pos;

@end
