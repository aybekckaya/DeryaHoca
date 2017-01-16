//
//  NSString+documentPath.h
//  DeryaHoca
//
//  Created by aybek can kaya on 16/11/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (documentPath)
{
    
}


+(NSString *)devicePath;


+(NSString *)devicePathWithDocumentFolderName:(NSString *)folderName;

-(BOOL)fileExistAtDevicePath;

-(void)createFolder:(NSString *)folderName;

-(void)removeItem;

@end
