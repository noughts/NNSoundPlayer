#import "NNSoundPlayer.h"


@implementation NNSoundPlayer{
	SystemSoundID _soundId;
	NSDate* _startTime;
}

-(instancetype)initWithName:(NSString*)name type:(NSString*)type{
	if( self = [self init] ){
		NSURL* url = [[NSBundle mainBundle] URLForResource:name withExtension:type];
		if( !url ){
			NSLog( @"音声ファイルがロードできません。Project Navigator でファイルを選択し、File Inspector の Target Membership で利用したいTargetにチェックが入っているか確認しましょう。" );
			return self;
		}
		if (AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_soundId) != kAudioServicesNoError){
			NSLog(@"error setting up Sound ID");
			return self;
		}
		AudioServicesAddSystemSoundCompletion(_soundId, CFRunLoopGetMain(), kCFRunLoopDefaultMode, muteCheckCompletionProc,(__bridge void *)(self));
		UInt32 yes = 1;
		AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(_soundId),&_soundId,sizeof(yes), &yes);
	}
	return self;
}


- (void)dealloc{
	if (_soundId != -1){
		AudioServicesRemoveSystemSoundCompletion(_soundId);
		AudioServicesDisposeSystemSoundID(_soundId);
	}
}





#pragma mark - public

-(void)play{
	if (_startTime == nil) {
		[self playInternal];
	} else {
		NSDate *now = [NSDate date];
		NSTimeInterval lastCheck = [now timeIntervalSinceDate:_startTime];
		if (lastCheck > 1) {	//prevent checking interval shorter then the sound length
			[self playInternal];
		}
	}
}






#pragma mark - その他


-(void)playInternal{
	_startTime = [NSDate date];
	AudioServicesPlaySystemSound(_soundId);
}

-(void)completed{
	NSDate *now = [NSDate date];
	NSTimeInterval t = [now timeIntervalSinceDate:_startTime];
	BOOL muted = (t > 0.1)? NO : YES;
	if( muted ){
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	}
}



/// Cスタイルの音声再生完了コールバック。
void muteCheckCompletionProc(SystemSoundID ssID, void* clientData){
	NNSoundPlayer *obj = (__bridge NNSoundPlayer *)clientData;
	[obj completed];
}


@end
