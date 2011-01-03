#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface CCNode (TestHook)
- (void)appendFrameToXml:(NSMutableString *)xml;
- (NSString *)accessibilityValue;
@end
