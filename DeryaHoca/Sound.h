//
//  Sound.h
//  SoundLibb
//
//  Created by aybek can kaya on 22/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


typedef void (^ SoundPlaySuccessBlock)(NSString * , float , float , BOOL, BOOL );
typedef void (^ SoundPlayFailureBlock)(NSError * , NSString * );

typedef void (^ SoundRecordSuccessBlock) (NSString *, float , float ,BOOL,BOOL);
typedef void (^ SoundRecordFailureBlock)(NSError * , NSString * );

typedef void (^ SoundPlayStackSuccessBlock)(NSString * ,int, int ,float , float , BOOL, BOOL );

@interface Sound : NSObject<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    SoundPlayFailureBlock sndPlayFailureBlock;
    SoundPlaySuccessBlock sndPlaySuccessBlock;
    
    SoundRecordFailureBlock sndRecordFailureBlock;
    SoundRecordSuccessBlock sndRecordSuccessBlock;
    
    SoundPlayStackSuccessBlock sndPlayStackBlock;
    
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    
    NSString *inputFileString ; // for audio player
    NSString *outputFileString;
    
    
    // Times in seconds
    float elapsedTime;
    float durationTotal;
    
    NSTimer *timerSound;
    
}

@property(nonatomic , readonly) BOOL isPlaying;
@property(nonatomic ,readonly) BOOL isRecording;


/*
 -(void) jsonQueryWithBlock:(NSString *)url success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
 failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure timeOut:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds))timeOut reachabilityError:(void (^)(NSURLRequest *request, id JSON, float timeOutSeconds,NSError *err))reachabilityError;
 
 */


#pragma mark PLAY Sound

-(void)playSound:(NSString *)path success:(void(^) (NSString *soundPath , float currentTime, float duration, BOOL didFinished , BOOL didPaused)) success failure:(void(^) (NSError *error , NSString *soundPath)) failure;

-(void)pausePlaying;

-(void)resumePlaying;

-(void)stopPlaying;

/**
   plays soundPaths of given stack Array from index 0 to end
 */
-(void)playSoundStack:(NSMutableArray *)stack success:(void(^) (NSString *soundPath , int index, int maxIndex ,float currentTime, float duration, BOOL didFinished , BOOL didPaused)) success failure:(void(^) (NSError *error , NSString *soundPath)) failure;



#pragma mark RECORD  Sound

/// currently only supports wav recording
/**
   @ unlimited recording time
 */
-(void)recordSound:(NSString *)outputFilePath success:(void(^)(NSString *outputPath , float currentTime , float duration , BOOL didFinished , BOOL didPaused))success failure:(void(^)(NSError *error , NSString *outputPath)) failure;

/**
  @ records until durationMax has reached
 */
-(void)recordSound:(NSString *)outputFilePath duration:(float)durationMax success:(void(^)(NSString *outputPath , float currentTime , float duration , BOOL didFinished , BOOL didPaused))success failure:(void(^)(NSError *error , NSString *outputPath)) failure;



-(void)pauseRecording;

-(void)resumeRecording;

-(void)stopRecording;





@end
