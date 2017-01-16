//
//  TFNetwork.m
//  NetWork
//
//  Created by aybek can kaya on 5/8/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "TFNetwork.h"


//#import "EPPZReachability.h"



#define TIME_OUT 10


typedef void (^ TimeOutBlock)(NSURLRequest *, id , float);

@implementation TFNetwork




-(void)jsonQueryWithBlock:(NSString *)url success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, id))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure timeOut:(void (^)(NSURLRequest *, id, float))timeOut reachabilityError:(void (^)(NSURLRequest *, id, float, NSError *))reachabilityError
{
   /*
  [Reachability reachabilityWithBlock:^(BOOL isReachable) {
     
     if(isReachable)
     {
         //NSLog(@"Reachable");
     }
      else
      {
           //NSLog(@"UN Reachable");
      }
      
  }];
    */
    
    // network connection tipine gorre degisecek
    float timeOutValue=TIME_OUT;
    
    TimeOutBlock blockTimeOut=timeOut;
   
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeOutValue target:self selector:@selector(timeOutSelector:) userInfo:@{@"block": blockTimeOut} repeats:NO];
    
    // make URL
   // url = [url urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlObj=[NSURL URLWithString:url];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlObj];
    
  [Reachability reachabilityWithBlock:^(BOOL isReachable) {
        
        if(isReachable)
        {
            //**network reachable**
            
            AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                
                //**On Success**
                [timer invalidate];
                timer=nil;
                
                //NSLog(@"JSON Parse Edilmis: %@", JSON);
                success(request,response,JSON);
                
                
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                // **On Error**
                    [timer invalidate];
                    timer=nil;
                failure(request,response,error,JSON);
                
             }];
            [operation start];

        }
        else
        {
            // **network unreachable**
            [timer invalidate];
            timer=nil;
            reachabilityError(nil,nil,timeOutValue,nil);
        }
        
    }];
    
    
    
    
}


-(void)sourceQueryWithBlock:(NSString *)url success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSData *, NSString *))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure timeOut:(void (^)(NSURLRequest *, id, float))timeOut reachabilityError:(void (^)(NSURLRequest *, id, float, NSError *))reachabilityError
{
    

    
    // network connection tipine gorre degisecek
    float timeOutValue=TIME_OUT;
    
    TimeOutBlock blockTimeOut=timeOut;
    
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeOutValue target:self selector:@selector(timeOutSelector:) userInfo:@{@"block": blockTimeOut} repeats:NO];
    
    // make URL
   //  url = [url urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlObj=[NSURL URLWithString:url];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlObj];
    
      [Reachability reachabilityWithBlock:^(BOOL isReachable) {
        
        if(isReachable)
        {
            //**network reachable**
            
            AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                // ** success **
                [timer invalidate];
                timer = nil;
                NSString *strData = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                success(urlRequest,nil,responseObject,strData);
                
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //**failure **
                 [timer invalidate];
                 timer = nil;
                 failure(urlRequest,nil,error,nil);
            }];
            [operation start];
        }
        else
        {
            // **network unreachable**
            [timer invalidate];
            timer=nil;
            reachabilityError(nil,nil,timeOutValue,nil);
        }
        
    }];
    

}


-(void)postQueryWithBlock:(NSString *)url postDictionary:(NSDictionary *)postDct fileDictionary:(NSArray *)fileDctArr success:(void (^)(NSString *, NSHTTPURLResponse *, NSString *, id))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure timeOut:(void (^)(NSURLRequest *, id, float))timeOut reachabilityError:(void (^)(NSURLRequest *, id, float, NSError *))reachabilityError
{
    NSString *boundary =@"0xKhTmLbOuNdArY";
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in postDct) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
      
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [postDct objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    for(NSDictionary *dct in fileDctArr)
    {
        
        UIImage *image = dct[@"image"];
        NSString *filename = dct[@"fileName"];
        
         NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString * FileParamConstant = @"fileToUpload";
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant , filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];

        
    }
    
    
    /*
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString * FileParamConstant = @"fileToUpload";
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    */
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:[NSURL URLWithString:url]];
    
    
    [Reachability reachabilityWithBlock:^(BOOL isReachable) {
       
        if(isReachable == YES)
        {
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                       
                                       NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                       
                                       if ([httpResponse statusCode] == 200)
                                       {
                                           NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                           NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                           
                                           
                                            success (url,nil,responseString , parsedObject);
                                       }
                                       else
                                       {
                                           // ** failure **
                                           
                                           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ulak" message:@"Bir hata oluştu . Lütfen tekrar deneyiniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
                                           [alert show];
                                           
                                           failure(nil,nil,error,nil);

                                       }
                                       
                                   }];
        }
        else
        {
            //** unreachable **
            reachabilityError(nil,nil,TIME_OUT,nil);
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ULAK" message:@"Lütfen internet bağlantınızı kontrol ediniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
    
   

}




-(void)postQueryWithBlock:(NSString *)url postDictionary:(NSDictionary *)postDct success:(void (^)(NSString *, NSHTTPURLResponse *, NSString * , id))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))failure timeOut:(void (^)(NSURLRequest *, id, float))timeOut reachabilityError:(void (^)(NSURLRequest *, id, float, NSError *))reachabilityError
{
    
    
    /*
     formatter.dateFormat = @"yyyyMMddHHmmss";
     NSString *dateString = [formatter stringFromDate:[NSDate date]];
     NSString *fileName =
     [NSString stringWithFormat:@"user_image_%@.jpg", dateString];
     
     NSDictionary *dictionary = @{
     @"user_id" : user._id,
     @"resource_id" : user._id,
     @"functioncode" : @"2000",
     @"app_id" : [WECURLGenerator stringOfAppID],
     @"file_name" : fileName
     };
     
     NSURLRequest *request = [[AFHTTPRequestSerializer serializer]
     multipartFormRequestWithMethod:
     @"POST" URLString:[WECURLGenerator stringOfImageUploadingBaseURL]
     parameters:dictionary
     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
     [formData
     appendPartWithFileData:UIImageJPEGRepresentation(image, 0.6)
     name:@"file1"
     fileName:fileName
     mimeType:@"jpg"];
     } error:(NULL)];
     
     AFHTTPRequestOperation *operation =
     [[AFHTTPRequestOperation alloc] initWithRequest:request];
     
     [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
     id responseObject) {
     NSDictionary *resultDict =
     [NSJSONSerialization JSONObjectWithData:responseObject
     options:NSJSONReadingMutableLeaves
     error:nil];
     resultBlock(resultDict[@"record"]);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     faliureBlock(error);
     }];
     
     [operation start];
     
     */
    
    
    
    
    
  //   url = [url urlEncodeUsingEncoding:NSUTF8StringEncoding];
    // split string
    NSArray *splitURL=[url componentsSeparatedByString:@"/"];
    
    NSString *baseURLOnQuery=@"";
    NSString *extensionURLOnQuery;
    
    for(int i=0 ; i< splitURL.count-1 ; i++)
    {
        baseURLOnQuery=[NSString stringWithFormat:@"%@/%@",baseURLOnQuery,splitURL[i]];
    }
    baseURLOnQuery=[baseURLOnQuery substringWithRange:NSMakeRange(1, baseURLOnQuery.length-1)];
    baseURLOnQuery=[NSString stringWithFormat:@"%@/",baseURLOnQuery];
    baseURLOnQuery=[baseURLOnQuery stringByReplacingOccurrencesOfString:@" " withString:@""];
    extensionURLOnQuery = splitURL[splitURL.count-1];
    
    NSDictionary *params = postDct;
    
    [Reachability reachabilityWithBlock:^(BOOL isReachable) {
        
        if(isReachable == YES)
         {
             //**reachable**
             AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                                     [NSURL URLWithString:baseURLOnQuery]];
             
             [client postPath:extensionURLOnQuery parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 // ** success **
                 NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                 
                 id theJSONObject = [TFJson JsonToObject:jsonStr];
                 
                 
                 if(theJSONObject == nil)
                 {
                     if(self.errorsDisabled)
                     {
                         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ulak" message:@"Bir hata oluştu . Lütfen tekrar deneyiniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
                         [alert show];
                     }

                    
                     failure(nil,nil,nil,nil);
                     return ;
                 }
                 
                 success (url,responseObject,jsonStr , theJSONObject);
                 
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                  // ** failure **
                 
                 
                 if(self.errorsDisabled)
                 {
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ulak" message:@"Bir hata oluştu . Lütfen tekrar deneyiniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
                     [alert show];
                 }
                     
                 
                
                 
                 failure(nil,nil,error,nil);
                 
             }];
         }
         else
         {
             //** unreachable **
             reachabilityError(nil,nil,TIME_OUT,nil);
             
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ULAK" message:@"Lütfen internet bağlantınızı kontrol ediniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
             [alert show];
         }
         
     }];


}



-(void) putQueryWithBlock:(NSString *)url putDictionary:(NSDictionary *)postDct success:(void (^)(NSString *theUrlStr, NSHTTPURLResponse *response, NSString * JSONString))success
                  failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure timeOut:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds))timeOut reachabilityError:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds,NSError *err))reachabilityError;
{
    
    //   url = [url urlEncodeUsingEncoding:NSUTF8StringEncoding];
    // split string
    NSArray *splitURL=[url componentsSeparatedByString:@"/"];
    
    NSString *baseURLOnQuery=@"";
    NSString *extensionURLOnQuery;
    
    for(int i=0 ; i< splitURL.count-1 ; i++)
    {
        baseURLOnQuery=[NSString stringWithFormat:@"%@/%@",baseURLOnQuery,splitURL[i]];
    }
    baseURLOnQuery=[baseURLOnQuery substringWithRange:NSMakeRange(1, baseURLOnQuery.length-1)];
    baseURLOnQuery=[NSString stringWithFormat:@"%@/",baseURLOnQuery];
    baseURLOnQuery=[baseURLOnQuery stringByReplacingOccurrencesOfString:@" " withString:@""];
    extensionURLOnQuery = splitURL[splitURL.count-1];
    
    NSDictionary *params = postDct;
    
    [Reachability reachabilityWithBlock:^(BOOL isReachable) {
        
        if(isReachable == YES)
        {
            //**reachable**
            AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                                    [NSURL URLWithString:baseURLOnQuery]];
            
            
            
            
            
            [client putPath:extensionURLOnQuery parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                // ** success **
                NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                success (url,responseObject,jsonStr);
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                // ** failure **
                
                failure(nil,nil,error,nil);
                
            }];
        }
        else
        {
            //** unreachable **
            reachabilityError(nil,nil,TIME_OUT,nil);
        }
        
    }];
    
    
}





- (void)timeOutSelector:(NSTimer *)timer
{
    NSDictionary *userDct = [timer userInfo];
     TimeOutBlock b=[userDct objectForKey:@"block"];
    b(nil,nil,0);
   
}


+(NSString *)connectionType
{
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    ////NSLog(@"Current Radio Access Technology: %@", telephonyInfo.currentRadioAccessTechnology);
    return telephonyInfo.currentRadioAccessTechnology;
}




@end
