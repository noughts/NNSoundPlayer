/*
   音声が再生されない時には、以下の点をチェックしてみましょう。
 
   - NNSoundPlayer がインスタンスのメンバとして定義されているか？
     関数内で初期化してもすぐにdeallocされてしまいます。
 
*/


@import Foundation;
@import AudioToolbox;


@interface NNSoundPlayer : NSObject


-(instancetype)initWithCompletionBlk;
-(void)play;

@end
