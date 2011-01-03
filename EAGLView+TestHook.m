//
//  EAGLView+TestHook.m
//  PenguinGame
//
//  Created by Jason Felice on 1/3/11.
//  Copyright 2011 Blue Frog Gaming. All rights reserved.
//

#import "EAGLView.h"
#import "EAGLView+TestHook.h"
#import "cocos2d.h"
#import "CCNode+TestHook.h"

@implementation EAGLView (TestHook)

- (void)appendChildrenToXml:(NSMutableString *)xml {
	SEL sel = NSSelectorFromString(@"appendToXml:");
	if (!sel)
		return;
	
	CCNode *root = [[CCDirector sharedDirector] runningScene];
	[root performSelector:sel withObject:xml];
}
	
@end
