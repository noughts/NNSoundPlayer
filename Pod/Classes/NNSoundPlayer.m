#import "NNSoundPlayer.h"

void MuteCheckCompletionProc(SystemSoundID ssID, void* clientData);

@interface NNSoundPlayer ()

@property (nonatomic, strong)NSDate *startTime;

-(void)completed;

@end

void MuteCheckCompletionProc(SystemSoundID ssID, void* clientData){
	NNSoundPlayer *obj = (__bridge NNSoundPlayer *)clientData;
	[obj completed];
}

@implementation NNSoundPlayer

-(void)playMuteSound{
	self.startTime = [NSDate date];
	AudioServicesPlaySystemSound(self.soundId);
}

-(void)completed{
	NSDate *now = [NSDate date];
	NSTimeInterval t = [now timeIntervalSinceDate:self.startTime];
	BOOL muted = (t > 0.1)? NO : YES;
	if( muted ){
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	}
}

-(void)check{
	if (self.startTime == nil) {
		[self playMuteSound];
	} else {
		NSDate *now = [NSDate date];
		NSTimeInterval lastCheck = [now timeIntervalSinceDate:self.startTime];
		if (lastCheck > 1) {	//prevent checking interval shorter then the sound length
			[self playMuteSound];
		}
	}
}


-(instancetype)initWithCompletionBlk{
	self = [self init];
	if (self) {
		NSURL* url = [[NSBundle mainBundle] URLForResource:@"message" withExtension:@"aif"];
		if (AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_soundId) == kAudioServicesNoError){
			AudioServicesAddSystemSoundCompletion(self.soundId, CFRunLoopGetMain(), kCFRunLoopDefaultMode, MuteCheckCompletionProc,(__bridge void *)(self));
			UInt32 yes = 1;
			AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(_soundId),&_soundId,sizeof(yes), &yes);
		} else {
			NSLog(@"error setting up Sound ID");
		}
	}
	return self;
}


- (void)dealloc{
	if (self.soundId != -1){
		AudioServicesRemoveSystemSoundCompletion(self.soundId);
		AudioServicesDisposeSystemSoundID(self.soundId);
	}
}

@end
