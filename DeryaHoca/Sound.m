//
//  Sound.m
//  SoundLibb
//
//  Created by aybek can kaya on 22/12/15.
//  Copyright © 2015 aybek can kaya. All rights reserved.
//

#import "Sound.h"

@implementation Sound


#pragma mark PLAY Sound

-(void)playSound:(NSString *)path success:(void (^)(NSString *, float, float, BOOL, BOOL))success failure:(void (^)(NSError *, NSString *))failure
{
    elapsedTime = 0;
    
    sndPlayFailureBlock = failure;
    sndPlaySuccessBlock = success;
    inputFileString = path;
    
    [timerSound invalidate];
    timerSound = nil;
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    NSError *error ;
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    player.delegate = self;
    
    if(error != nil)
    {
        sndPlayFailureBlock(error , inputFileString);
        return;
    }
    
    
    [player prepareToPlay];
    
    durationTotal = player.duration;
    [self performSelector:@selector(playReal) withObject:nil afterDelay:0.1];
    
}

-(void)playReal
{
    if(timerSound == nil)
    {
        timerSound = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTickForPlaying) userInfo:nil repeats:YES];
    }
    
    [player play];
}


-(void)stopPlaying
{
    
    sndPlaySuccessBlock(inputFileString , elapsedTime , durationTotal , YES , NO);
    
    [player stop];
    
    elapsedTime = 0;
    [timerSound  invalidate];
    timerSound = nil;
}

-(void)pausePlaying
{
    [player pause];
}


-(void)resumePlaying
{
    [player setCurrentTime:elapsedTime];
}


-(void)playSoundStack:(NSMutableArray *)stack success:(void (^)(NSString *, int, int, float, float, BOOL, BOOL))success failure:(void (^)(NSError *, NSString *))failure
{
  
    sndPlayStackBlock = success;
    [self playSoundStackHelper:stack];
    
}


-(void)playSoundStackHelper:(NSMutableArray *)arrStack
{
    if(arrStack.count == 0)
    {
        // success block
        
        sndPlayStackBlock(nil , 0,0,0,0,YES,YES);
        return;
    }
    
    NSString *sound = [arrStack objectAtIndex:0];
    [arrStack removeObjectAtIndex:0];
    
    __weak Sound *weakSelf = self;
    
    [self playSound:sound success:^(NSString *soundPath, float currentTime, float duration, BOOL didFinished, BOOL didPaused) {
       
        //NSLog(@"Play !!!");
        
        
        if(didFinished == YES)
        {
            [weakSelf playSoundStackHelper:arrStack];
        }
        else
        {
            
        }
        
    } failure:^(NSError *error, NSString *soundPath) {
        
    }];
    
}



-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    sndPlaySuccessBlock(inputFileString , elapsedTime , durationTotal , YES , YES);
    [timerSound invalidate];
    timerSound=nil;
}

#pragma mark RECORD  Sound

-(void)recordSound:(NSString *)outputFilePath success:(void (^)(NSString *, float, float, BOOL, BOOL))success failure:(void (^)(NSError *, NSString *))failure
{
    
    if(self.isRecording)
    {
        return;
    }
    
    elapsedTime = 0;
    
    [timerSound invalidate];
    timerSound = nil;
    
    sndRecordSuccessBlock = success;
    sndRecordFailureBlock = failure;
    
    outputFileString = outputFilePath;
    NSURL *outputFileURL = [NSURL fileURLWithPath:outputFilePath];
    
    
    // Setup audio session
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    if(error != nil)
    {
        sndRecordFailureBlock(error , outputFilePath);
        return;
    }
    
    
      
     NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue :[NSNumber  numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    
    

    
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:&error];
    
    if(error != nil)
    {
        sndRecordFailureBlock(error , outputFilePath);
        return;
    }

    
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    [self performSelector:@selector(startRecording) withObject:nil afterDelay:0.1];
    
}

-(void)recordSound:(NSString *)outputFilePath duration:(float)durationMax success:(void (^)(NSString *, float, float, BOOL, BOOL))success failure:(void (^)(NSError *, NSString *))failure
{
    durationTotal = durationMax;
    
    
    
    timerSound = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTickForRecording) userInfo:nil repeats:YES];
    
    [self recordSound:outputFilePath success:success failure:failure];
}



-(void)startRecording
{
    elapsedTime = 0;
    
    NSError *error ;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:&error];
    
    if(error != nil)
    {
         sndRecordFailureBlock(error , outputFileString);
        return;
    }
    
    elapsedTime = 0;
    
    [self timerTickForRecording];
    
     timerSound = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTickForRecording) userInfo:nil repeats:YES];
    
    
    // Start recording
    [recorder record];
}



-(void)pauseRecording
{
    [recorder pause];
}

-(void)stopRecording
{
    [recorder stop];
    
    NSError *error ;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:&error];
    
    [timerSound invalidate];
    timerSound = nil;
    
    if(error != nil)
    {
        sndRecordFailureBlock(error , outputFileString);
        return;
    }
    else
    {
          sndRecordSuccessBlock(outputFileString , elapsedTime , durationTotal ,YES , NO);
    }
}

-(void)resumeRecording
{
    
}


-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
}



#pragma mark TIMER

-(void)timerTickForRecording
{
    
    if(elapsedTime >= durationTotal)
    {
        [self stopRecording];
        
    }
    else
    {
        sndRecordSuccessBlock(outputFileString , elapsedTime , durationTotal ,NO , NO);
    }
    
    elapsedTime ++;
}



-(void)timerTickForPlaying
{
    if(player.isPlaying == NO)
    {
        
    }
    else
    {
        
        
        sndPlaySuccessBlock(inputFileString , elapsedTime , durationTotal , NO,NO);
    
        
        elapsedTime ++;
    }
    
   
}



#pragma mark READONLY

-(BOOL)isPlaying
{
    return player.playing;
}


-(BOOL)isRecording
{
    return recorder.recording;
}


@end
