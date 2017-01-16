//
//  DBConnectable.m
//  mstApp
//
//  Created by aybek can kaya on 30/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "DBConnectable.h"


#define DATABASE_NAME @"DeryaHoca.sqlite"


@implementation DBConnectable

-(id)init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}


-(TFDatabase *)database
{
    TFDatabase *DB  = [[TFDatabase alloc]InitWithDatabaseName:DATABASE_NAME];
    return DB;
}



-(void)createTableIfNotExists:(NSDictionary *) dctObjectTypes
{
    
  //  NSDictionary *dctRepresentation = [objectCopy getDictionary];
    
    NSMutableDictionary *dctMute = [[NSMutableDictionary alloc]init];
   
    
   // NSDictionary *objectTypesDct = [objectCopy objectTypes];
    
     NSString *query = @"CREATE TABLE ";
    query = [NSString stringWithFormat:@"%@%@(" ,query, self.tableName];
    
    NSArray *keys = [dctObjectTypes allKeys];
    
    for(NSString *theKey in keys)
    {
        NSString *type = dctObjectTypes[theKey];
        if([type isEqualToString:@"integer"])
        {
            query = [NSString stringWithFormat:@"%@ %@ INTEGER NOT NULL DEFAULT 0," , query, theKey];
        }
        else if([type isEqualToString:@"float"])
        {
             query = [NSString stringWithFormat:@"%@ %@ FLOAT NOT NULL DEFAULT 0," , query, theKey];
        }
        else if([type isEqualToString:@"NSString"])
        {
            query = [NSString stringWithFormat:@"%@ %@ TEXT NOT NULL DEFAULT ''," , query, theKey];
        }
        else if([type isEqualToString:@"long"])
        {
            query = [NSString stringWithFormat:@"%@ %@ INTEGER NOT NULL DEFAULT 0," , query, theKey];
        }
    }
    
    query = [query substringWithRange:NSMakeRange(0, query.length-1)];
    query = [NSString stringWithFormat:@"%@)" , query];
    

    // Test Query
    /*
    query =@"CREATE TABLE tbl_kategoriStudent( name TEXT NOT NULL DEFAULT '', puntoLabel INTEGER NOT NULL DEFAULT 0, frameString TEXT NOT NULL DEFAULT '', studentID INTEGER NOT NULL DEFAULT 0, ID INTEGER NOT NULL DEFAULT 0, clBgMn TEXT NOT NULL DEFAULT '', parentID INTEGER NOT NULL DEFAULT 0, clBgYazi TEXT NOT NULL DEFAULT '', imagePlace TEXT NOT NULL DEFAULT '', sesEnabled INTEGER NOT NULL DEFAULT 0, isSelectedItem INTEGER NOT NULL DEFAULT 0, kategoriID INTEGER NOT NULL DEFAULT 0, typeKategori INTEGER NOT NULL DEFAULT 0, yaziEnabled INTEGER NOT NULL DEFAULT 0, gorselEnabled INTEGER NOT NULL DEFAULT 0, fontName TEXT NOT NULL DEFAULT '')";
    
    
    query = @"CREATE TABLE tbl_kategoriStudent( name TEXT NOT NULL DEFAULT '', puntoLabel INTEGER NOT NULL DEFAULT 0, frameString TEXT NOT NULL DEFAULT '', studentID INTEGER NOT NULL DEFAULT 0, ID INTEGER NOT NULL DEFAULT 0, clBgMn TEXT NOT NULL DEFAULT '', parentID INTEGER NOT NULL DEFAULT 0, clBgYazi TEXT NOT NULL DEFAULT '', imagePlace TEXT NOT NULL DEFAULT '', sesEnabled INTEGER NOT NULL DEFAULT 0, chosenItem INTEGER NOT NULL DEFAULT 0, kategoriID INTEGER NOT NULL DEFAULT 0, typeKategori INTEGER NOT NULL DEFAULT 0, yaziEnabled INTEGER NOT NULL DEFAULT 0, gorselEnabled INTEGER NOT NULL DEFAULT 0, fontName TEXT NOT NULL DEFAULT '')";
    */
    
    TFDatabase *db = [self database];
   BOOL res = [db Query:query];
    
    
    // debug
    /*
    if(![self tableExists:self.tableName])
    {
        //NSLog(@"not created");
    }
    else
    {
        //NSLog(@"created");
        
        [db Query:@"DROP TABLE tbl_kategoriStudent"];
        
        if([self tableExists:self.tableName])
        {
            //NSLog(@"not Dropped");
        }
        else
        {
            //NSLog(@"Dropped");
        }
        
    }
     */
    
    
}


-(BOOL)tableExists:(NSString *)tableName
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@" , tableName];
    
 //   query = @"SELECT * FROM Womana";
    
    TFDatabase *DB = [self database];
    FMResultSet *res = [DB Query:query];
    
    BOOL exist = YES;
    if(res == nil)
    {
        exist = NO;
    }
    
    return exist;
}



/**
    table needs alter ?
 */
-(void)updateTable:(id)objectCopy
{
    TFDatabase *db = [self database];
    
    if(![self tableExists:self.tableName])
    {
        [self createTableIfNotExists:[objectCopy objectTypes]];
    }
    
    NSArray *allColumnNames = [db allColumnNames:self.tableName];
    NSDictionary *allObjectFieldsDcts = [objectCopy objectTypes];
    
    NSArray *objectFieldsKeys = [allObjectFieldsDcts allKeys];
    
    // needs add
    
    for(NSString *fieldName in objectFieldsKeys)
    {
        if(![allColumnNames containsObject:fieldName])
        {
            // add
            
            [self alterAddFieldName:fieldName fieldType:allObjectFieldsDcts[fieldName]];
        }
    }
    
    // needs drop
    
    /*
     // Sqlite does not support drop
    for(NSString *columnName in allColumnNames)
    {
        if(![objectFieldsKeys containsObject:columnName])
        {
            [self alterDropFieldName:columnName];
        }
    }
    */
}



-(void)alterAddFieldName:(NSString *)fieldName fieldType:(NSString *)typeField
{
    NSString *query = [NSString stringWithFormat:@"ALTER TABLE %@ ADD " , self.tableName ];
    
    NSString *type = typeField;
    NSString *theKey = fieldName;
    
    if([type isEqualToString:@"integer"])
    {
        query = [NSString stringWithFormat:@"%@ %@ INTEGER NOT NULL DEFAULT 0" , query, theKey];
    }
    else if([type isEqualToString:@"float"])
    {
        query = [NSString stringWithFormat:@"%@ %@ FLOAT NOT NULL DEFAULT 0 " , query, theKey];
    }
    else if([type isEqualToString:@"NSString"])
    {
        query = [NSString stringWithFormat:@"%@ %@ TEXT NOT NULL DEFAULT ''" , query, theKey];
    }
    else if([type isEqualToString:@"long"])
    {
        query = [NSString stringWithFormat:@"%@ %@ INTEGER NOT NULL DEFAULT 0" , query, theKey];
    }

    TFDatabase *db = [self database];
    [db Query:query];
    
    
    NSString *query2 = [NSString stringWithFormat:@"UPDATE %@ SET %@=0" , self.tableName , fieldName ];
    
    if([type isEqualToString:@"NSString"])
    {
        query2 = [NSString stringWithFormat:@"UPDATE %@ SET %@=''" , self.tableName , fieldName ];
    }
    
    TFDatabase *db2 = [self database];
    [db2 Query:query2];
    
}


-(void)alterDropFieldName:(NSString *)fieldName
{
    
    NSString *query = [NSString stringWithFormat:@"ALTER TABLE %@ DROP %@" , self.tableName , fieldName];
    
    TFDatabase *db = [self database];
    [db Query:query];
}




/*
-(NSArray *)allColumnNamesInTable:(NSString *) tableName
{
    NSMutableArray *columnNames = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"DESCRIBE %@" , self.tableName];
    TFDatabase *db = [self database];
   FMResultSet *res = [db Query:query];
    
    while([res next])
    {
        NSString *fieldName = [res stringForColumn:@"Field"];
    }
    
    return [[NSArray alloc]initWithArray:columnNames];
}
*/

/**
 @return : newly added object's ID
 */
-(void)save:(id)objectCopy
{
    
    NSDictionary *dctObjectTypes = [objectCopy objectTypes];
    
    if(![self tableExists:self.tableName])
    {
        [self createTableIfNotExists:dctObjectTypes];
    }
    
    
    // try to select Item
    NSDictionary *dctRepresentation = [objectCopy getDictionary];
    int primaryKeyVal = [dctRepresentation[self.primaryKey] intValue];
    
    NSArray *objectsArr = [self getModelResultPrimaryKeyValue:primaryKeyVal objectTypesDictionary:dctObjectTypes];
    
    
    if(objectsArr.count == 0 )
    {
        // needs insert
        NSString *query = [self insertQueryForObject:objectCopy];
        //NSLog(@"query : %@" , query);
        
        TFDatabase *db = [self database];
        [db Query:query];
        
    }
    else
    {
        // needs update
        NSString *query = [self updateQueryForObject:objectCopy];
        TFDatabase *db = [self database];
        [db Query:query];
    }

    
    
    /*
    if(![self tableExists:self.tableName])
    {
           [self createTableIfNotExists:objectCopy];
    }

    // try to select Item
    NSDictionary *dctRepresentation = [objectCopy getDictionary];
    int primaryKeyVal = [dctRepresentation[self.primaryKey] intValue];
    
    NSDictionary *dctObjectTypes =
    NSArray *objectsArr = [self getModelResultPrimaryKeyValue:primaryKeyVal objectCopy:objectCopy];
    
   // int objectID ;
    if(objectsArr.count == 0 )
    {
        // needs insert
        NSString *query = [self insertQueryForObject:objectCopy];
        TFDatabase *db = [self database];
        [db Query:query];
        
    }
    else
    {
       // needs update
        NSString *query = [self updateQueryForObject:objectCopy];
        TFDatabase *db = [self database];
        [db Query:query];
    }
    
    return currentObjectID;
     
     */
    
    
  
     
}


-(void)removeModelPrimaryKeyValue:(int)primaryKeyValue
{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@=%d" , self.tableName , self.primaryKey , primaryKeyValue];
    
    if(primaryKeyValue == -1)
    {
        query = [NSString stringWithFormat:@"DELETE FROM %@" , self.tableName ];
    }
    
    TFDatabase *db = [self database];
    [db Query:query];
}




-(NSString *)insertQueryForObject:(id)objectCopy
{
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO %@(" , self.tableName];
    
    NSDictionary *dctObject = [objectCopy getDictionary];
    NSDictionary *typesDct = [objectCopy objectTypes];
    
    NSArray *allKeys = [dctObject allKeys];
    
    NSString *keysString = @"";
    NSString *valuesString = @"";
    
    for(NSString *key in allKeys)
    {
        NSString *typeKey = typesDct[key];
        
        if([self.primaryKey isEqualToString:key])
        {
            int theID = [dctObject[key] intValue];
           
            keysString = [NSString stringWithFormat:@"%@%@," , keysString , key];
            valuesString = [NSString stringWithFormat:@"%@%d," , valuesString , theID];
        }
        else
        {
            if([typeKey isEqualToString:@"integer"])
            {
                int val = [dctObject[key] intValue];
                keysString = [NSString stringWithFormat:@"%@%@," , keysString , key];
                valuesString = [NSString stringWithFormat:@"%@%d," , valuesString , val];
            }
            else if([typeKey isEqualToString:@"float"])
            {
                double val = [dctObject[key] doubleValue];
                
                keysString = [NSString stringWithFormat:@"%@%@," , keysString , key];
                valuesString = [NSString stringWithFormat:@"%@%f," , valuesString , val];
                
            }
            else if([typeKey isEqualToString:@"NSString"])
            {
                NSString *str = dctObject[key];
                keysString = [NSString stringWithFormat:@"%@%@," , keysString , key];
                valuesString = [NSString stringWithFormat:@"%@'%@'," , valuesString , str];
            }
            else if([typeKey isEqualToString:@"long"])
            {
                long val = [dctObject[key] longValue];
                keysString = [NSString stringWithFormat:@"%@%@," , keysString , key];
                valuesString = [NSString stringWithFormat:@"%@%ld," , valuesString , val];
            }
            else
            {
                NSString *str = dctObject[key];
                keysString = [NSString stringWithFormat:@"%@%@," , keysString , key];
                valuesString = [NSString stringWithFormat:@"%@'%@'," , valuesString , str];
                
            }

        }
        
        
    }
    
    keysString = [keysString substringWithRange:NSMakeRange(0, keysString.length-1)];
    valuesString = [valuesString substringWithRange:NSMakeRange(0, valuesString.length - 1)];
    
    query = [NSString stringWithFormat:@"%@%@) VALUES(%@)" , query , keysString , valuesString];
    
    
    return query;
     
    
}

-(NSString *)updateQueryForObject:(id)objectCopy
{
    
    NSString *query = [NSString stringWithFormat:@"UPDATE %@ SET " , self.tableName];
    
    NSDictionary *dctObject = [objectCopy getDictionary];
    NSDictionary *typesDct = [objectCopy objectTypes];
    
    NSArray *allKeys = [dctObject allKeys];

    NSString *setString = @"";
    for(NSString *key in allKeys)
    {
        NSString *typeKey = typesDct[key];
        
        if([typeKey isEqualToString:@"integer"])
        {
            int val = [dctObject[key] intValue];
            setString = [NSString stringWithFormat:@"%@%@=%d," , setString , key , val];
          
        }
        else if([typeKey isEqualToString:@"float"])
        {
            double val = [dctObject[key] doubleValue];
            
            setString = [NSString stringWithFormat:@"%@%@=%f," , setString , key , val];
            
            
        }
        else if([typeKey isEqualToString:@"NSString"])
        {
            NSString *str = dctObject[key];
            setString = [NSString stringWithFormat:@"%@%@='%@'," , setString , key , str];
         
        }
        else if([typeKey isEqualToString:@"long"])
        {
            long val = [dctObject[key] longValue];
            setString= [NSString stringWithFormat:@"%@%@=%ld," , setString , key , val];
            
        }
        else
        {
            NSString *str = dctObject[key];
            setString = [NSString stringWithFormat:@"%@%@='%@'," , setString , key , str];
            
        }

    }
    
    
    // Where Clause
    int primaryVal = [dctObject[self.primaryKey] intValue];
   
    
    NSString *whereClause = [NSString stringWithFormat:@" WHERE %@=%d" , self.primaryKey , primaryVal];
    
    setString = [setString substringWithRange:NSMakeRange(0, setString.length-1)];
    
    NSString *queryFull = [NSString stringWithFormat:@"%@%@%@" , query , setString , whereClause];
    
    
    return queryFull;
    
}



-(int) newIDForTable
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ ", self.tableName ];
    TFDatabase *db = [self database];
    FMResultSet *res = [db Query:query];
    
    int maxID =0;
    
    while ([res next])
    {
        int ID = [res intForColumn:self.primaryKey];
        if(ID > maxID)
        {
            maxID = ID;
        }
    }
    
    int newID = maxID +1;
    
    return newID;
}


-(NSArray *)getModelResultPrimaryKeyValue:(int)primaryKeyValue objectTypesDictionary:(NSDictionary *)dctObjectTypes
{
    NSMutableArray*resultsArr = [[NSMutableArray alloc]init];
    
    if(![self tableExists:self.tableName])
    {
        [self createTableIfNotExists:dctObjectTypes];
        
        return resultsArr;
    }
    
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@=%d", self.tableName , self.primaryKey , primaryKeyValue];
    
    if(primaryKeyValue == -1)
    {
        query = [NSString stringWithFormat:@"SELECT * FROM %@ ", self.tableName ];
    }
    
  
    
    //NSDictionary *objectTypesDct = dctObjectTypes;
    //NSArray *objectTypesKeys = [dctObjectTypes allKeys];
    
    TFDatabase *db = [self database];
    FMResultSet *res = [db Query:query];
    
    //NSString *className = NSStringFromClass([objectCopy class]);
    
    NSArray *resArr = [DBConnectable arrResultsFromResultSet:res objectTypesDictionary:dctObjectTypes];
 
    
    return resArr;
    
    //return [[NSArray alloc]initWithArray:resultsArr];
}



-(NSArray *)getModeltsByFilter:(NSDictionary *)dctFilter objectTypesDictionary:(NSDictionary *)dctObjectTypes
{
    NSMutableArray*resultsArr = [[NSMutableArray alloc]init];
    
    if(![self tableExists:self.tableName])
    {
        [self createTableIfNotExists:dctObjectTypes];
        
        return resultsArr;
    }
    
    // generate where clause

    NSArray *dctFilterKeys = [dctFilter allKeys];
    
    if(dctFilterKeys.count == 0)
    {
         return [[NSArray alloc]initWithArray:resultsArr];
    }
    else
    {
        NSString *whereClause = @"WHERE ";
        
        NSMutableArray *arrMuteWhereClause = [[NSMutableArray alloc] init];
        
        for(NSString *key in dctFilterKeys)
        {
            id object = dctFilter[key];
            
            if([object isKindOfClass:[NSString class]])
            {
               NSString *whereClauseInner = [NSString stringWithFormat:@"%@='%@'" , key ,object];
                
                [arrMuteWhereClause addObject:whereClauseInner];
            }
            else
            {
                NSString *whereClauseInner = [NSString stringWithFormat:@"%@=%@" , key ,object];
                
                [arrMuteWhereClause addObject:whereClauseInner];

            }
        }
        
        NSString *strWhereClauseSuffix = [arrMuteWhereClause componentsJoinedByString:@" AND "];
        NSString *whereCL = [NSString stringWithFormat:@" WHERE %@", strWhereClauseSuffix];
        
        NSString *fullQuery = [NSString stringWithFormat:@"SELECT * FROM %@ %@" , self.tableName , whereCL];
        
        TFDatabase *db = self.databaseInstance;
        
        FMResultSet *res = [db Query:fullQuery];
        
        NSArray *resArr = [DBConnectable arrResultsFromResultSet:res objectTypesDictionary:dctObjectTypes];
        
        return resArr;
        
    }
    
   
    
    

     return [[NSArray alloc]initWithArray:resultsArr];
    
}



+(NSArray *)arrResultsFromResultSet:(FMResultSet *)res objectTypesDictionary:(NSDictionary *)dctObjectTypes
{
    NSMutableArray *resultsArr = [[NSMutableArray alloc] init];
    
    //NSDictionary *objectTypesDct = dctObjectTypes;
    NSArray *objectTypesKeys = [dctObjectTypes allKeys];
    
    while([res next])
    {
        NSMutableDictionary *dctMuteObject = [[NSMutableDictionary alloc]init];
        for(NSString *key in objectTypesKeys)
        {
            // id objNew = [[NSClassFromString(className) alloc] init];
            
            NSString *typeKey =dctObjectTypes[key];
            
            if([typeKey isEqualToString:@"integer"])
            {
                int val = [res intForColumn:key];
                [dctMuteObject setObject:@(val) forKey:key];
            }
            else if([typeKey isEqualToString:@"float"])
            {
                double val = [res doubleForColumn:key];
                [dctMuteObject setObject:@(val) forKey:key];
            }
            else if([typeKey isEqualToString:@"NSString"])
            {
                NSString *str = [res stringForColumn:key];
                
                if(str == nil)
                {
                    str = @"";
                }
                
                [dctMuteObject setObject:str forKey:key];
            }
            else if([typeKey isEqualToString:@"long"])
            {
                long val = [res longForColumn:key];
                [dctMuteObject setObject:@(val) forKey:key];
            }
            else
            {
                NSString *str = [res stringForColumn:key];
                [dctMuteObject setObject:str forKey:key];
            }
            
        }
        
        // id objNew = [[NSClassFromString(className) alloc] init];
        //[objNew setDictionary:dctMuteObject];
        
        [resultsArr addObject:dctMuteObject];
    }
    
    
    return [[NSArray alloc] initWithArray:resultsArr];
}





-(FMDatabase *)databaseInstance
{
    TFDatabase *db = [[TFDatabase alloc] InitWithDatabaseName:DATABASE_NAME];
    return db;
}



/*
+(NSMutableArray *)getAllItemsFromTableName:(NSString *)tableName objectTypesDictionary:(NSDictionary *)dctObjectTypes
{
    
}
*/


@end
