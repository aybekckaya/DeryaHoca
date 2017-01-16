//
//  BottomBarStackController.h
//  DeryaHoca
//
//  Created by aybek can kaya on 05/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_INFO_ID @"ID"
#define USER_INFO_SCROLL_CURRENT_PAGE @"scrollPage"


@interface BottomBarObject : NSObject
{
    
}

@property(nonatomic) id viewObject;
@property(nonatomic ,strong) NSDictionary *userInfo;

@end




@interface BottomBarStackController : NSObject
{
    NSMutableArray *stackCurrent;
}

@property(nonatomic , readonly) NSMutableArray *stack;

+(id)shared;

-(void)push:(BottomBarObject *)object;

-(void)popToIndex:(int) index;

-(void)popAllElements;

@end
