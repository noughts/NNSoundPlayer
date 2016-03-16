//
//  NNViewController.m
//  NNSoundPlayer
//
//  Created by Koichi Yamamoto on 03/16/2016.
//  Copyright (c) 2016 Koichi Yamamoto. All rights reserved.
//

#import "NNViewController.h"
#import <NNSoundPlayer.h>

@implementation NNViewController{
	NNSoundPlayer* _player;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	_player = [[NNSoundPlayer alloc] initWithName:@"message" type:@"aif"];
	_player.vibrateIfInSilentMode = YES;
}


-(IBAction)hoge:(id)sender{
	[_player play];
}


@end
