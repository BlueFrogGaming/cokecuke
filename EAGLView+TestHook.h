//
//  EAGLView+TestHook.h
//  PenguinGame
//
//  Created by Jason Felice on 1/3/11.
//  Copyright 2011 Blue Frog Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EAGLView (TestHook)

- (void)appendChildrenToXml:(NSMutableString *)xml;

@end
