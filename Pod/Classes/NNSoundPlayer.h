/*
   音声が再生されない時には、以下の点をチェックしてみましょう。
 
   - NNSoundPlayer がインスタンスのメンバとして定義されているか？
     関数内で初期化してもすぐにdeallocされてしまいます。
 
 //音声ファイルがロードできません。Project Navigator でファイルを選択し、File Inspector の Target Membership で利用したいTargetにチェックが入っているか確認しましょう。
*/


@import Foundation;
@import AudioToolbox;


@interface NNSoundPlayer : NSObject


-(instancetype)initWithCompletionBlk;
-(void)check;

@end
