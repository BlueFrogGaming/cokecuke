#import "CCNode+TestHook.h"

@implementation CCNode (TestHook)

- (void)appendFrameToXml:(NSMutableString *)xml {
	CGRect frame = [self boundingBox];
	frame.origin = [[self parent] convertToWorldSpace:frame.origin];
	
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
