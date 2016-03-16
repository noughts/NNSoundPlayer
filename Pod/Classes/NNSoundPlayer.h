@import Foundation;
@import AudioToolbox;

typedef void (^MuteCheckCompletionHandler)(NSTimeInterval lapse, BOOL muted);

@interface NNSoundPlayer : NSObject

// this class must use with a MuteChecker.caf (a 0.2 sec mute sound) in Bundle

@property (nonatomic,assign) SystemSoundID soundId;
@property (strong) MuteCheckCompletionHandler completionBlk;

-(instancetype)initWithCompletionBlk:(MuteCheckCompletionHandler)completionBlk;
-(void)check;

@end
