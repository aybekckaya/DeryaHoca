//
//  Settings.m
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "Settings.h"

@implementation Settings

-(id)init
{
    if(self = [super init])
    {
        list = [[Plist alloc] initWithPlistName:@"Users"];
    }
    
    return self;
}



-(id)initWithUserID:(int)theUserID
{
    if(self = [super init])
    {
         list = [[Plist alloc] initWithPlistName:@"Users"];
        self.userID = theUserID;
        
        [self loadVariablesFromPlist];
    }
    
    return self;
}


#pragma mark SETTERS 
/*
-(void)setUserID:(int)userID
{
    _userID = userID;
    
    
    [self loadVariablesFromPlist];
}


-(void)setImagesEnabled:(BOOL) imagesEnabled
{
    _imagesEnabled = imagesEnabled;
    
    [self save];
}


-(void)setWritingEnabled:(BOOL)writingEnabled
{
    _writingEnabled = writingEnabled;
    
    [self save];
}
*/


#pragma mark PLIST OPERATIONS 

-(void)save
{
    if(self.userID != 0)
    {
        NSString *userIDStr = [NSString stringWithFormat:@"%d" , self.userID];
       BOOL userExist = [list keyExists:userIDStr];
        
        if(userExist == NO)
        {
           // load default values
            NSDictionary *dctSelf = [self getDictionary];
            NSMutableDictionary *dctMute = [[NSMutableDictionary alloc] initWithDictionary:dctSelf];
         
            
            [list write:dctMute Key:userIDStr];
            
        }
        else
        {
            NSDictionary *dct = [self getDictionary];
            
            //NSLog(@"dct : %@" , dct);
            
            [list write:dct Key:userIDStr];
        }
        
        
    }
}


-(void)loadVariablesFromPlist
{
    if(self.userID != 0)
    {
        NSString *userIDStr = [NSString stringWithFormat:@"%d" , self.userID];
        BOOL userExist = [list keyExists:userIDStr];
        
        if(userExist == NO)
        {
            [self setWithDefaultValues];
        }
        else
        {
            NSDictionary *dct = [list read:userIDStr];
            [self setDictionary:dct];
        }
        
        
    }

}



-(void)setWithDefaultValues
{
    self.cumleSeridiEnabled = YES;
    self.cumleSeridiSilmeTusuEnabled = YES;
    
    self.typeSesTuru = kSesTuruFemale;
    self.frameStringBottomBar = @"0,0,0,0";
    self.frameStringStudentNavBar = @"0,0,0,0";
    self.frameStringPageControl = @"0,0,0,0";
     self.frameStringCategoryScroll = @"0,0,0,0";
    
    [self save];
}


+(BOOL)userExist:(int) user_id
{
    Settings *stTemp = [[Settings alloc]init];
    
    NSString *userIDStr = [NSString stringWithFormat:@"%d" , user_id];
    BOOL userExist = [[stTemp getPlist] keyExists:userIDStr];
    
    return userExist;
    
   
}




#pragma mark Unit Testing Area

-(Plist *)getPlist
{
    return list;
}







@end
