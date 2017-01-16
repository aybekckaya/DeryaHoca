//
//  NSString+documentPath.m
//  DeryaHoca
//
//  Created by aybek can kaya on 16/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "NSString+documentPath.h"

@implementation NSString (documentPath)

+(NSString *)devicePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


+(NSString *)devicePathWithDocumentFolderName:(NSString *)folderName
{
    NSString *pathInit = [self devicePath];
    NSString *fullPath = [pathInit stringByAppendingPathComponent:folderName];
    
    return fullPath;
}

-(BOOL)fileExistAtDevicePath
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: self])
    {
        return YES;
    }
    
    return NO;
}


-(void)createFolder:(NSString *)folderName
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    
    NSString *nameFolder = [NSString stringWithFormat:@"/%@" , folderName];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:nameFolder];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
         [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    }
    
}


-(void)removeItem
{
    [[NSFileManager defaultManager] removeItemAtPath:self error:nil];
}




@end
