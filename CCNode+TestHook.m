#import "CCNode+TestHook.h"

#import <objc/objc-runtime.h>

@implementation CCNode (TestHook)

- (void)appendFrameToXml:(NSMutableString *)xml {
	// Convert node space to world space
	CGRect frame = CGRectMake(0, 0, self.contentSizeInPixels.width, self.contentSizeInPixels.height);
	CGAffineTransform t = [self nodeToWorldTransform];
	frame = CGRectApplyAffineTransform(frame, t);
	frame = CC_RECT_PIXELS_TO_POINTS(frame);

	// Convert world space (GL) to UI space (within the EAGLView)
	CGPoint a = [[CCDirector sharedDirector] convertToUI:frame.origin];
	CGPoint b = [[CCDirector sharedDirector] convertToUI:ccp(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height)];	
	frame = CGRectMake(a.x, a.y, b.x - a.x, b.y - a.y);
	frame = CGRectStandardize(frame);

	// Convert from view space within the EAGLView to orientation-independent screen coordinates
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
