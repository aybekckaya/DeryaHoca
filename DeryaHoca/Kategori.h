//
//  Kategori.h
//  DeryaHoca
//
//  Created by aybek can kaya on 02/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "DBConnectable.h"
#import "NSString+documentPath.h"
#import <UIKit/UIKit.h>
#import "NSString+component.h"

typedef enum KategoriType
{
    kKategoriTypeKategori,
    kKategoriTypeResim,
    kKategoriTypeNone
    
}KategoriType;


typedef enum KategoriSesTuruType
{
    kKategoriSesTuruTypeMale,
    kKategoriSesTuruTypeFemale
}KategoriSesTuruType;


@interface Kategori : DBConnectable
{
   
}

@property(nonatomic) int ID;
@property(nonatomic) KategoriType typeKategori;

@property(nonatomic) int parentID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic ,strong) NSString *imagePlace;
@property(nonatomic) int puntoLabel;

@property(nonatomic , strong) NSString *clBgYazi;
@property(nonatomic ,strong) NSString *clBgMn; // color bg main

@property(nonatomic ,strong) NSString *fontName;


@property(nonatomic ) int yaziEnabled;
@property(nonatomic) int gorselEnabled;
@property(nonatomic) int sesEnabled;

// Default variables 
@property(nonatomic , strong) NSString *cntPtMn;
@property(nonatomic ,strong) NSString *cntPtImView;
@property(nonatomic ,strong) NSString *cntPtLbl;

@property(nonatomic) float scMn;
@property(nonatomic) float scImView; // do not change dynamically -> change only in kategoriEkleVC
@property(nonatomic)float scLbl; // do not change dynamically -> change only in kategoriEkleVC
@property (nonatomic , strong) NSString *frLbl;



-(id)initWithID:(int ) theID;

-(void)saveModel;

-(void)removeModel;

-(NSString *)getSoundFullPath:(KategoriSesTuruType) typeSesTuru;

-(void)removeSounds;

+(NSMutableArray *)getAllItems;

+(void)removeAllItems;

/**
   @return : children of element in 1 level
 */
+(NSArray *)kategoriDctsArrByParentID:(int) parentID;


+(NSArray *)kategoriDctsArrByParentID:(int)parentID filter:(KategoriType) typeFilter;


/**
  @return : all children of given kategori ID(parentID)
 */
+(NSArray *)allChildrenDictionariesOfKategoriID:(int) kategoriID;


+(NSArray *)allParentKategoriDctsByKategoriID:(int) kategoriID;


#pragma mark Methods Inner 

-(void) saveCategoryImage:(UIImage *)image;

-(UIImage *)getCategoryImage;



@end
