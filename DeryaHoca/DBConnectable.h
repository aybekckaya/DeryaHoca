//
//  DBConnectable.h
//  mstApp
//
//  Created by aybek can kaya on 30/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "TFDatabase.h"
#import "NSObject+KJSerializer.h"

/**
   - create table if not exists 
   - save model when parameter given as dictionary  (update or insert selection when primary key given. if found in db then update else insert )
    - get model all (if primary key given -1) else get model dictionary 
    - delete model (if pk is -1 then delete all models )
 
 */

@interface DBConnectable : TFDatabase
{
  //  int currentObjectID;
}

/**
   usually ID -> nsstring
 */
@property(nonatomic,strong) NSString *primaryKey;

/**
    set from child model
 */
@property(nonatomic,strong) NSString *tableName;


/**
  @return : new Instance of database for complex queries
 */
@property(nonatomic ,readonly) TFDatabase *databaseInstance;



-(void)save:(id) objectCopy;

/**
 @return: NSDictionary representation of model
 */
-(NSArray *)getModelResultPrimaryKeyValue:(int) primaryKeyValue objectTypesDictionary:(NSDictionary *)dctObjectTypes;

-(void)updateTable:(id)objectCopy;

-(int) newIDForTable;

-(void)removeModelPrimaryKeyValue:(int)primaryKeyValue;

/**
   dct Filter is the where clause of query 
 */
-(NSArray *)getModeltsByFilter:(NSDictionary *)dctFilter objectTypesDictionary:(NSDictionary *)dctObjectTypes;


/**
   @return : dictionaries of items
 */
//+(NSMutableArray *)getAllItemsFromTableName:(NSString *)tableName objectTypesDictionary:(NSDictionary *)dctObjectTypes;



+(NSArray *)arrResultsFromResultSet:(FMResultSet *)res objectTypesDictionary:(NSDictionary *)dctObjectTypes;



@end
