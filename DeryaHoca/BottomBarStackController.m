//
//  BottomBarStackController.m
//  DeryaHoca
//
//  Created by aybek can kaya on 05/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "BottomBarStackController.h"


@implementation BottomBarObject



@end


@implementation BottomBarStackController

+(id)shared
{
    static BottomBarStackController *cnt = nil;
    
    if(cnt == nil)
    {
        cnt = [[self alloc] init];
    }
    
    return cnt;
}

-(id)init
{
    if(self = [super init])
    {
        stackCurrent = [[NSMutableArray alloc] init];
    }
    
    return self;
}


-(void)push:(BottomBarObject *)object
{
    [stackCurrent addObject:object];
}


-(void)popToIndex:(int)index
{
    
    
    int numPops = stackCurrent.count - index -1;
    
    for(int i = 0 ; i< numPops ; i++)
    {
        [stackCurrent removeLastObject];
    }
}

-(NSMutableArray *)stack
{
    return stackCurrent;
}


-(void)popAllElements
{
    stackCurrent = [[NSMutableArray alloc] init];
}


@end
