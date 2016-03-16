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
	_player = [[NNSoundPlayer alloc] initWithCompletionBlk];
}


-(IBAction)hoge:(id)sender{
	[_player check];
}


@end
