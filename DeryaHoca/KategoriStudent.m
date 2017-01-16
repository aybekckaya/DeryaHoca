//
//  KategoriStudent.m
//  DeryaHoca
//
//  Created by aybek can kaya on 06/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "KategoriStudent.h"

@implementation KategoriStudent

-(id)init
{
    if(self = [super init])
    {
        [self initialize];
        [super updateTable:self];
    }
    
    return self;
}


-(id)initWithID:(int)theID
{
    if(self = [super init])
    {
        
        self.ID = theID;
        
        [self initialize];
        [super updateTable:self];
        
        [self setData];
    }
    
    return self;
}



-(void)initialize
{
    self.tableName = @"tbl_kategoriStudent";
    self.primaryKey = @"ID";
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





-(void)saveModel
{
    [super save:self];
}

-(void)removeModel
{
    
    NSString *devicePath = [NSString devicePath];
    NSString *imageFullPath = [NSString stringWithFormat:@"%@/kategoriImages/%d_%d.JPG" , devicePath , self.kategoriID, self.studentID];
    
    [imageFullPath removeItem];
    
    [super removeModelPrimaryKeyValue:self.ID];
}




-(UIImage *)getCategoryImage
{
    
        NSString *devicePath = [NSString devicePath];
        NSString *imageFullPath = [NSString stringWithFormat:@"%@/kategoriImages/%d_%d.JPG" , devicePath , self.ID, self.studentID];
        
        
        if(![imageFullPath fileExistAtDevicePath])
        {
            return nil;
        }
        
        
        NSData *data = [NSData dataWithContentsOfFile:imageFullPath];
        UIImage *image = [UIImage imageWithData:data];
        
        return image;

}


-(void)saveCategoryImage:(UIImage *)image
{
    
    if(image == nil)
    {
        return;
    }
    
    NSString *folderName = @"kategoriImages";
    
    [folderName createFolder:folderName];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.7);
    NSString *path = [NSString devicePathWithDocumentFolderName:folderName];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%d_%d.JPG" , path , self.ID , self.studentID];
    
    self.imagePlace = @"asd";
    
    [data writeToFile:fullPath atomically:YES];
}




#pragma mark Static Methods

+(void)removeAllItems
{
    KategoriStudent *st = [[KategoriStudent alloc] init];
    [st removeModelPrimaryKeyValue:-1];
}

+(NSArray *)getAllItems
{
    KategoriStudent *tempObject = [[KategoriStudent alloc]init];
    NSDictionary *dctObjectTypes = [tempObject objectTypes];
    NSArray *arr = [tempObject getModelResultPrimaryKeyValue:-1 objectTypesDictionary:dctObjectTypes];
    
    return arr;
}


+(NSArray *)getKategoriStudentDictionariesByStudentID:(int)studentID parentID:(int)parentID
{
    KategoriStudent *tempObject = [[KategoriStudent alloc] init];
    NSDictionary *objectTypes = [tempObject objectTypes];
    
    NSDictionary *dctFilter = @{@"parentID" : @(parentID) , @"studentID":@(studentID)};
    
    NSArray *resArr = [tempObject getModeltsByFilter:dctFilter objectTypesDictionary:objectTypes];
    
    
    return resArr;
}




+(NSArray *)getAllChildKategoriStudentsByStudentID:(int)studentID parentID:(int)parentID
{
    NSMutableArray *childrenDictionaries = [[NSMutableArray alloc] init];
    
    
    int counter = 0;
    
    while (counter == 0 || counter <= childrenDictionaries.count)
    {
        NSArray *arrChildren;
        
        if(counter == 0)
        {
            arrChildren = [KategoriStudent getKategoriStudentDictionariesByStudentID:studentID parentID:parentID];
            
        }
        else
        {
            NSDictionary *dctCurrent = childrenDictionaries[counter-1];
            int ID = [dctCurrent[@"ID"] intValue];
            
            arrChildren = [KategoriStudent getKategoriStudentDictionariesByStudentID:studentID parentID:ID];
            
        }
        
        for(NSDictionary *dct in arrChildren)
        {
            // //NSLog(@"id : %d" , [dct[@"ID"] intValue]);
            ////NSLog(@"counter : %d" , counter);
            [childrenDictionaries addObject:dct];
        }
        
        
        counter ++ ;
    }
    
    
    
    return [[NSArray alloc] initWithArray:childrenDictionaries];
}


+(KategoriStudent *)getItemByKategoriID:(int)catID studentID:(int)stID
{
    KategoriStudent *tempObject = [[KategoriStudent alloc] init];
    NSDictionary *objectTypes = [tempObject objectTypes];
    
    NSDictionary *dctFilter = @{@"kategoriID" : @(catID) , @"studentID":@(stID)};
    
    NSArray *resArr = [tempObject getModeltsByFilter:dctFilter objectTypesDictionary:objectTypes];
    
    if(resArr.count == 0)
    {
        return nil;
    }

    NSDictionary *dctItem = resArr[0];
    
    KategoriStudent *kt = [[KategoriStudent alloc] init];
    [kt setDictionary:dctItem];
    
    return kt;
}


+(KategoriStudent *)kategoriStudentObjectFromKategoriDct:(NSDictionary *)dctKategori studentID:(int)studentID
{
    KategoriStudent *st = [[KategoriStudent alloc] init];
    [st setDictionary:dctKategori];
    
   
    st.studentID = studentID;
    st.ID = [st newIDForTable];
    st.kategoriID = [dctKategori[@"ID"] intValue];
    
        
    return st;
}

-(void)removeSounds
{
    NSString *male = [self getSoundFullPath:kKategoriStudentSesTuruTypeMale];
    if([male fileExistAtDevicePath])
    {
        [male removeItem];
    }
    
    NSString *female = [self getSoundFullPath:kKategoriStudentSesTuruTypeFemale];
    if([female fileExistAtDevicePath])
    {
        [female removeItem];
    }
    
    
    
}

-(void)copySoundsMalePath:(NSString *)pathMale femalePath:(NSString *)pathFemale
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *ktMalePath = [self getSoundFullPath:kKategoriStudentSesTuruTypeMale];
    if(pathMale != nil )
    {
         [fileManager copyItemAtPath:pathMale toPath:ktMalePath error:nil];
    }
   
    
    NSString *ktFemalePath = [self getSoundFullPath:kKategoriStudentSesTuruTypeFemale];
    
    if(pathFemale != nil )
    {
          [fileManager copyItemAtPath:pathFemale toPath:ktFemalePath error:nil];
    }
    
  
    
}

-(NSString *)getSoundFullPath:(KategoriStudentSesTuruType)typeSesTuru
{
    NSString *dcPath = [NSString devicePathWithDocumentFolderName:@"Sounds"];
    
    if(![dcPath fileExistAtDevicePath])
    {
        [dcPath createFolder:@"Sounds"];
    }
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%d_%d_male.wav" , dcPath , self.ID , self.studentID];
    
    if(typeSesTuru == kKategoriStudentSesTuruTypeFemale)
    {
        fullPath = [NSString stringWithFormat:@"%@/%d_%d_female.wav" , dcPath , self.ID , self.studentID];
    }
    
    
    return fullPath;
    
}





+(NSArray *)kategoriIDsArrByStudentID:(int)studentID
{
    KategoriStudent *tempObject = [[KategoriStudent alloc] init];
    NSDictionary *objectTypes = [tempObject objectTypes];
    
    NSDictionary *dctFilter = @{ @"studentID":@(studentID)};
    
    NSArray *resArr = [tempObject getModeltsByFilter:dctFilter objectTypesDictionary:objectTypes];
    
    if(resArr.count == 0)
    {
        return [[NSArray alloc] init];
    }

    NSMutableArray *arrFinal = [[NSMutableArray alloc] init];
    for(NSDictionary *dct in resArr)
    {
        int kategoriID = [dct[@"kategoriID"] intValue];
        
        [arrFinal addObject:@(kategoriID)];
    }
    
    
    return [[NSArray alloc] initWithArray:arrFinal];
}


@end
