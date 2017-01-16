//
//  Settings.h
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Plist.h"
#import "NSObject+KJSerializer.h"

typedef enum SettingsSesTuru
{
    kSesTuruFemale ,
    kSesTuruMale
    
}SettingsSesTuru;


@interface Settings : NSObject
{
    Plist *list;
}

@property(nonatomic ) int userID;

//@property(nonatomic ) BOOL imagesEnabled;
//@property(nonatomic ) BOOL writingEnabled;

@property(nonatomic ) BOOL cumleSeridiEnabled;
@property(nonatomic) BOOL cumleSeridiSilmeTusuEnabled;

@property(nonatomic) SettingsSesTuru typeSesTuru;

@property(nonatomic ,strong) NSString *frameStringBottomBar;
@property(nonatomic ,strong) NSString *frameStringStudentNavBar;
@property(nonatomic ,strong) NSString *frameStringCategoryScroll;
@property(nonatomic ,strong) NSString *frameStringPageControl;




-(id)initWithUserID:(int) theUserID;

-(void)save;

+(BOOL)userExist:(int) user_id;

#pragma mark Unit Testing Area

-(Plist *) getPlist;




@end
