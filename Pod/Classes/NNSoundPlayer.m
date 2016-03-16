//
//  NNSoundPlayer.m
//  Pods
//
//  Created by noughts on 2016/03/16.
//
//

#import "NNSoundPlayer.h"


@implementation NNSoundPlayer{
	AVAudioPlayer* _player;
}

-(instancetype)initWithName:(NSString*)name type:(NSString*)type{
	if( self = [super init] ){
		NSString* str = [[NSBundle mainBundle] pathForResource:name ofType:type];
		if( !str ){
			NSLog( @"音声ファイルがロードできません。Project Navigator でファイルを選択し、File Inspector の Target Membership で利用したいTargetにチェックが入っているか確認しましょう。" );
			return self;
		}
		NSURL* url = [NSURL URLWithString:str];
		NSError* error = nil;
		_player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
		if( error ){
			NSLog( @"%@", error );
		}
		_player.delegate = self;
		[_player prepareToPlay];
	}
	return self;
}

-(void)dealloc{
	
}

-(void)play{
	[_player play];
	NSLog(@"start");
}

#pragma mark - AVAudioPlayerDelegate

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
	
}
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
	
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
	NSLog(@"finish");
}
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
	
}


@end
