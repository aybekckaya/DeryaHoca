//
//  User.m
//  DeryaHoca
//
//  Created by aybek can kaya on 15/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "User.h"

@implementation User


+(id)currentUser
{
    
    User *theUser;
    
    Plist *listUser = [[Plist alloc]initWithPlistName:@"UserList"];
    int currentUserID = [[listUser read:@"currentUserID"] intValue];
    
    
        
        if(currentUserID == 0)
        {
            theUser = [[User alloc] init];
        }
        else
        {
             theUser = [[User alloc]initWithID:currentUserID];
        }
        
    
    return theUser;
}



+(void)resetCurrentUser
{
    Plist *listUser = [[Plist alloc]initWithPlistName:@"UserList"];
    [listUser removeObjectWithKey:@"currentUserID"];
}


-(void)setAsCurrentUser
{
    Plist *listUser = [[Plist alloc]initWithPlistName:@"UserList"];
    [listUser write:@(self.ID) Key:@"currentUserID"];
}



-(NSString *)profileImageURL
{
    NSString *folderName = @"profileImages";
    [folderName createFolder:folderName];
    
    NSString *path = [NSString devicePathWithDocumentFolderName:folderName];
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%d.JPG" , path , self.ID];
    
    BOOL fileExist = [fullPath fileExistAtDevicePath];
    
    if(fileExist == YES)
    {
        return fullPath;
    }
    
    return nil;
}


-(void)saveProfileImage:(UIImage* )profileImage
{
    NSString *folderName = @"profileImages";
    NSData *data = UIImageJPEGRepresentation(profileImage, 0.7);
    NSString *path = [NSString devicePathWithDocumentFolderName:folderName];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%d.JPG" , path , self.ID];
    
    [data writeToFile:fullPath atomically:YES];
}

-(UIImage *)getProfileImage
{
    NSString *profileImageURL = [self profileImageURL];
    if(profileImageURL == nil)
    {
        UIImage *img = [UIImage imageNamed:@"userDefault.png"];
        
        return img;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:profileImageURL];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}


-(id)init
{
    if(self = [super init])
    {
        [self initializeModel];
        [super updateTable:self];
    }
    
    return self;
}



-(id)initWithID:(int)theID
{
    if(self = [super init])
    {
        self.ID = theID;
        
        [self initializeModel];
        [super updateTable:self];
        
        [self setData];
    }
    
    return self;
}


-(void)initializeModel
{
    self.primaryKey = @"ID";
    self.tableName = @"tbl_users";
    
}

-(void)removeProfileImage
{
    NSString *profileStr = [self profileImageURL];
    [profileStr removeItem];
    
}

-(void)saveModel
{
    [super save:self];
}

-(void)removeModel
{
    [super removeModelPrimaryKeyValue:self.ID];
}

-(void)setData
{
    NSDictionary *dctObjectTypes = [self objectTypes];
    NSArray *modelsDcts = [super getModelResultPrimaryKeyValue:self.ID objectTypesDictionary:dctObjectTypes];
    
    if(modelsDcts.count > 0)
    {
        NSDictionary *dctModel = modelsDcts[0];
        [self setDictionary:dctModel];
    }
    
    // //NSLog(@"%@" , modelsDcts);
    
    
}


+(void)removeAllItems
{
    User *theUserTemp = [[User alloc]init];
    [theUserTemp removeModelPrimaryKeyValue:-1];
}


+(NSMutableArray *)allUsers
{
    User *userTemp = [[User alloc]init];
    NSDictionary *objectTypes = [userTemp objectTypes];
    
    NSArray *arrRawItems = [userTemp getModelResultPrimaryKeyValue:-1 objectTypesDictionary:objectTypes];
    
    NSMutableArray *arrMute = [[NSMutableArray alloc]initWithArray:arrRawItems
    ];
    
    return arrMute;
}


@end
