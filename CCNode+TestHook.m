#import "CCNode+TestHook.h"

@implementation CCNode (TestHook)

- (void)appendFrameToXml:(NSMutableString *)xml {
	CGRect frame = CGRectMake(0, 0, self.contentSizeInPixels.width, self.contentSizeInPixels.height);
	CGAffineTransform t = [self nodeToWorldTransform];
	frame = CGRectApplyAffineTransform(frame, t);
	frame = CC_RECT_PIXELS_TO_POINTS(frame);
	
	frame = [[[CCDirector sharedDirector] openGLView] convertRect:frame toView:nil];
	frame = [[[UIApplication sharedApplication] keyWindow] convertRect:frame toWindow:nil];
	
	[xml appendFormat: @"<frame x=\"%f\" y=\"%f\" width=\"%f\" height=\"%f\"/>",
	  frame.origin.x, frame.origin.y, frame.size.width, frame.size.height];	
}

- (void)appendChildrenToXml:(NSMutableString *)xml {
	SEL sel = NSSelectorFromString(@"appendToXml:");
	if (sel)
		for (CCNode *child in self.children)
			[child performSelector:sel withObject:xml];
}

- (BOOL)isAccessibilityElement {
	return YES;
}

- (NSString *)accessibilityValue {
	NSString *value = [super accessibilityValue];
	if (value != nil)
		return value;
	
	if (![self conformsToProtocol:@protocol(CCLabelProtocol)])
		return nil;
	
	id<CCLabelProtocol> label = (id<CCLabelProtocol>) self;
	return [label string];
}
							
@end
