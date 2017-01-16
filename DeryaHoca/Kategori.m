//
//  Kategori.m
//  DeryaHoca
//
//  Created by aybek can kaya on 02/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "Kategori.h"

@implementation Kategori

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
    self.tableName = @"tbl_kategori";
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
    [super removeModelPrimaryKeyValue:self.ID];
}


+(NSMutableArray *)getAllItems
{
    Kategori *userTemp = [[Kategori alloc]init];
    NSDictionary *objectTypes = [userTemp objectTypes];
    
    NSArray *arrRawItems = [userTemp getModelResultPrimaryKeyValue:-1 objectTypesDictionary:objectTypes];
    
    NSMutableArray *arrMute = [[NSMutableArray alloc]initWithArray:arrRawItems
                               ];
    
    return arrMute;
}

+(void)removeAllItems
{
    Kategori *kategoriTemp = [[Kategori alloc] init];
    [kategoriTemp removeModelPrimaryKeyValue:-1];
}






#pragma mark Methods Inner 





-(void)saveCategoryImage:(UIImage *)image
{
    NSString *folderName = @"kategoriImages";
    
    [folderName createFolder:folderName];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.7);
    NSString *path = [NSString devicePathWithDocumentFolderName:folderName];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%d.JPG" , path , self.ID];
    
    self.imagePlace = @"asd";
    
    [data writeToFile:fullPath atomically:YES];
}

-(UIImage *)getCategoryImage
{
    NSString *devicePath = [NSString devicePath];
    NSString *imageFullPath = [NSString stringWithFormat:@"%@/kategoriImages/%d.JPG" , devicePath , self.ID];
    
   // NSLog(@"%@ : %@" , self.name , imageFullPath);
    
    
    if(![imageFullPath fileExistAtDevicePath])
    {
        // look at bundle source
        
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d" , self.ID] ofType:@"JPG"];
        UIImage *theImage = [UIImage imageWithContentsOfFile:filePath];
        
        /*
        if(theImage == nil )
        {
            NSLog(@"image ID : %d , name : %@" , self.ID , self.name);
        }
       */
        
        return theImage;
    }
    
    
    NSData *data = [NSData dataWithContentsOfFile:imageFullPath];
    UIImage *image = [UIImage imageWithData:data];
    
    
  
    
    return image;
    
    
  
}


+(NSArray *)kategoriDctsArrByParentID:(int)parentID
{
    Kategori *ktTemp = [[Kategori alloc] init];
    
    NSDictionary *dctFilter = @{@"parentID" :@(parentID) };
    
    NSDictionary *dctObjectTypes = [ktTemp objectTypes];
    NSArray *arrDcts = [ktTemp getModeltsByFilter:dctFilter objectTypesDictionary:dctObjectTypes];
    
    
    
    
    return arrDcts;
}



+(NSArray *)allChildrenDictionariesOfKategoriID:(int)kategoriID
{
    NSMutableArray *childrenDictionaries = [[NSMutableArray alloc] init];
    
    
    int counter = 0;
    
    while (counter == 0 || counter <= childrenDictionaries.count)
    {
        NSArray *arrChildren;
        
        if(counter == 0)
        {
            arrChildren = [Kategori kategoriDctsArrByParentID:kategoriID];
            
        }
        else
        {
            NSDictionary *dctCurrent = childrenDictionaries[counter-1];
            int ID = [dctCurrent[@"ID"] intValue];
            
            arrChildren = [Kategori kategoriDctsArrByParentID:ID];
        
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


-(void)removeSounds
{
    NSString *male = [self getSoundFullPath:kKategoriSesTuruTypeMale];
    if([male fileExistAtDevicePath])
    {
        [male removeItem];
    }
    
    NSString *female = [self getSoundFullPath:kKategoriSesTuruTypeFemale];
    
    if([female fileExistAtDevicePath])
    {
        [female removeItem];
    }
    
}

-(NSString *)getSoundFullPath:(KategoriSesTuruType)typeSesTuru
{
    NSString *dcPath = [NSString devicePathWithDocumentFolderName:@"Sounds"];
    
    if(![dcPath fileExistAtDevicePath])
    {
        [dcPath createFolder:@"Sounds"];
    }
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%d_male.wav" , dcPath , self.ID];
    
    if(typeSesTuru == kKategoriSesTuruTypeFemale)
    {
        fullPath = [NSString stringWithFormat:@"%@/%d_female.wav" , dcPath , self.ID];
    }
    
    
    if(![fullPath fileExistAtDevicePath])
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d_male" , self.ID] ofType:@"wav"];
        
        if(typeSesTuru == kKategoriSesTuruTypeFemale)
        {
           filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d_female" , self.ID] ofType:@"wav"];
        }
        
        return filePath;
    }
    
    
    return fullPath;
    
}



+(NSArray *)kategoriDctsArrByParentID:(int)parentID filter:(KategoriType)typeFilter
{
    Kategori *ktTemp = [[Kategori alloc] init];
    
    NSDictionary *dctFilter = @{@"parentID" :@(parentID) };
    
    if(typeFilter == kKategoriTypeNone)
    {
        dctFilter = @{@"parentID" :@(parentID) };
    }
    else if(typeFilter == kKategoriTypeKategori)
    {
        dctFilter = @{@"parentID" :@(parentID) };
    }
    else if(typeFilter == kKategoriTypeResim)
    {
        dctFilter = @{@"typeKategori": @(kKategoriTypeResim)};
    }
    
    
    NSDictionary *dctObjectTypes = [ktTemp objectTypes];
    NSArray *arrDcts = [ktTemp getModeltsByFilter:dctFilter objectTypesDictionary:dctObjectTypes];

    return arrDcts;
}



+(NSArray *)allParentKategoriDctsByKategoriID:(int)kategoriID
{
    NSMutableArray *arrParentDcts = [[NSMutableArray alloc] init];
    
    Kategori *kt = [[Kategori alloc] initWithID:kategoriID];
    int parentID = kt.parentID;
    
    while (parentID != -1)
    {
        kt = [[Kategori alloc] initWithID:parentID];
        parentID = kt.parentID;
        NSDictionary *dct = [kt getDictionary];
        [arrParentDcts addObject:dct];
        
        
    }
    
    
    return [[NSArray alloc] initWithArray:arrParentDcts];
}



@end
