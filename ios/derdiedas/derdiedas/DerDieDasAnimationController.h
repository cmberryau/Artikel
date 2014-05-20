//
//  DerDieDasAnimationController.h
//  derdiedas
//
//  Created by Christopher Berry on 29/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DerDieDasAnimationController : NSObject

// shakes the layer in the X direction + and - offset for a duration
// of seconds for a full shake cycle
+(CAKeyframeAnimation *) DoShake:(CALayer *) layer
                            offset:(CGFloat) offset
                            duration:(CFTimeInterval) duration
                            delegate:(id) delegate;

// fades the layer in over a duration of seconds
+(CABasicAnimation *) DoFadeIn:(CALayer *) layer
                             duration:(CFTimeInterval) duration
                             delegate:(id) delegate;

// fades the layer out over a duration of seconds
+(CABasicAnimation *) DoFadeOut:(CALayer *) layer
                              duration:(CFTimeInterval) duration
                              delegate:(id) delegate;

// moves the layer along x and y axis over a duration of seconds
+(CABasicAnimation *) DoMove:(CALayer*) layer
                          xmove:(CGFloat) xmove
                          ymove:(CGFloat) ymove
                          duration:(CFTimeInterval) duration
                          delegate:(id) delegate;
@end
