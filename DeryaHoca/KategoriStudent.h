//
//  KategoriStudent.h
//  DeryaHoca
//
//  Created by aybek can kaya on 06/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "DBConnectable.h"

#import "NSString+documentPath.h"
#import <UIKit/UIKit.h>
#import "NSString+component.h"


typedef enum KategoriStudentSesTuruType
{
    kKategoriStudentSesTuruTypeMale,
    kKategoriStudentSesTuruTypeFemale
    
}KategoriStudentSesTuruType;



typedef enum KategoriTypeStudent
{
    kKategoriTypeKategoriStudent,
    kKategoriTypeResimStudent
    
}KategoriTypeStudent;


@interface KategoriStudent : DBConnectable
{
    
}

@property(nonatomic) int ID;
@property(nonatomic) int studentID;
@property(nonatomic) int kategoriID;

// category specs for student

@property(nonatomic) KategoriTypeStudent typeKategori;

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

/*
@property(nonatomic , strong) NSString *cntPtMn;
@property(nonatomic ,strong) NSString *cntPtImView;
@property(nonatomic ,strong) NSString *cntPtLbl;


@property(nonatomic , strong) NSString *scMn;
@property(nonatomic ,strong) NSString *scImView;
@property(nonatomic ,strong) NSString *scLbl;
*/

@property(nonatomic , strong) NSString *cntPtMn;
@property(nonatomic ,strong) NSString *cntPtImView;
@property(nonatomic ,strong) NSString *cntPtLbl;

@property(nonatomic) float scMn;
@property(nonatomic) float scImView; // do not change dynamically -> change only in kategoriEkleVC
@property(nonatomic)float scLbl; // do not change dynamically -> change only in kategoriEkleVC
@property (nonatomic , strong) NSString *frLbl;




// for Kategori View
@property(nonatomic ) int chosenItem;


-(id)initWithID:(int)theID;


-(void)saveModel;

-(void)removeModel;

-(void)removeSounds;

-(UIImage *)getCategoryImage;

-(void)saveCategoryImage:(UIImage *)image;

-(NSString *)getSoundFullPath:(KategoriStudentSesTuruType) typeSesTuru;

// save (copy ) sound

-(void)copySoundsMalePath:(NSString *)pathMale femalePath:(NSString *)pathFemale;

#pragma mark Static Methods

+(void)removeAllItems ;

+(NSArray *)getAllItems;


+(NSArray *)kategoriIDsArrByStudentID:(int) studentID;


/**
  
 */
+(NSArray *) getKategoriStudentDictionariesByStudentID:(int) studentID parentID:(int) parentID;


+(NSArray *)getAllChildKategoriStudentsByStudentID :(int) studentID parentID:(int) parentID;

/**
  @return  nil if there is no item , else return KategoriStudent Object
 */
+(KategoriStudent *)getItemByKategoriID:(int) catID studentID:(int) stID;


+(KategoriStudent *)kategoriStudentObjectFromKategoriDct:(NSDictionary *)dctKategori studentID:(int) studentID;

@end
