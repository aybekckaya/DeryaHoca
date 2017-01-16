//
//  User.h
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConnectable.h"
#import "Plist.h"
#import "NSString+documentPath.h"
#import <UIKit/UIKit.h>

@interface User : DBConnectable
{
    
}

@property(nonatomic , assign) int ID;

@property(nonatomic) NSString *name;
//@property(nonatomic ,assign) NSString *profileImageURL;


+(id)currentUser;

+(void) resetCurrentUser;

-(void)setAsCurrentUser;

/**
    @return : profile Image full path if profile image has set 
   else return nil
 */
//-(NSString *)profileImageURL;

-(UIImage *)getProfileImage;

-(void)saveProfileImage:(UIImage *)profileImage;

-(void)removeProfileImage;

-(id)initWithID:(int ) theID;

-(void)saveModel;

-(void)removeModel;

/**
 @return array of dictionaries of model Data
 */
+(NSMutableArray *)allUsers;


+(void)removeAllItems;



@end
