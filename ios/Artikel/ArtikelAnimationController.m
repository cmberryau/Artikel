//
//  ArtikelAnimationController.m
//  Artikel
//
//  Created by Christopher Berry on 18/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//
//  Artikel is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 2 of the License, or
//  (at your option) any later version.
//
//  Artikel is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Artikel. If not, see <http://www.gnu.org/licenses/>.

#import "ArtikelAnimationController.h"

@implementation ArtikelAnimationController

// shakes the layer in the X direction + and - offset for a duration
// of duration for a full shake cycle
+(CAKeyframeAnimation *) DoShake:(CALayer *) layer
                            offset:(CGFloat) offset
                            duration:(CFTimeInterval) duration
                            delegate:(id) delegate
{
    CAKeyframeAnimation * shake_anim = [CAKeyframeAnimation animation];
    CGMutablePathRef shake_path = CGPathCreateMutable();
    CGPathMoveToPoint(shake_path, NULL, layer.position.x, layer.position.y);
    
    for(int index = 0; index<3; index++)
    {
        CGPathAddLineToPoint(shake_path, NULL,
                             layer.position.x-offset, layer.position.y);
        CGPathAddLineToPoint(shake_path, NULL,
                             layer.position.x+offset, layer.position.y);
    }
    
    CGPathCloseSubpath(shake_path);
    shake_anim.path = shake_path;
    shake_anim.duration = duration;
    shake_anim.delegate = delegate;
    
    [layer addAnimation:shake_anim forKey:@"position"];
    
    return shake_anim;
}

// fades the layer in over a duration of seconds
+(CABasicAnimation *) DoFadeIn:(CALayer *) layer
                             duration:(CFTimeInterval) duration
                             delegate:(id) delegate
{
    CABasicAnimation * fade_anim = [CABasicAnimation animation];
    fade_anim.fromValue = [NSNumber numberWithFloat:0.0f];
    fade_anim.toValue = [NSNumber numberWithFloat:1.0f];
    fade_anim.removedOnCompletion = NO;
    fade_anim.fillMode = kCAFillModeForwards;
    fade_anim.duration = duration;
    fade_anim.delegate = delegate;
    
    [layer addAnimation:fade_anim forKey:@"opacity"];
    
    return fade_anim;
}

// fades the layer out over a duration of seconds
+(CABasicAnimation *) DoFadeOut:(CALayer *) layer
                              duration:(CFTimeInterval) duration
                              delegate:(id) delegate
{
    CABasicAnimation * fade_anim = [CABasicAnimation animation];
    fade_anim.fromValue = [NSNumber numberWithFloat:1.0f];
    fade_anim.toValue = [NSNumber numberWithFloat:0.0f];
    fade_anim.removedOnCompletion = NO;
    fade_anim.fillMode = kCAFillModeForwards;
    fade_anim.duration = duration;
    fade_anim.delegate = delegate;
    
    [layer addAnimation:fade_anim forKey:@"opacity"];
    
    return fade_anim;
}

// moves the layer along x and y axis over a duration of seconds
+(CABasicAnimation *) DoMove:(CALayer*) layer
                          xmove:(CGFloat) xmove
                          ymove:(CGFloat) ymove
                          duration:(CFTimeInterval) duration
                          delegate:(id) delegate
{
    CGPoint to_point = layer.position;
    to_point.x += xmove; to_point.y += ymove;
    
    CABasicAnimation * move_anim = [CABasicAnimation animationWithKeyPath:@"position"];
    move_anim.fromValue = [NSValue valueWithCGPoint:layer.position];
    move_anim.toValue = [NSValue valueWithCGPoint:to_point];
    move_anim.removedOnCompletion = NO;
    move_anim.fillMode = kCAFillModeForwards;
    move_anim.duration = duration;
    move_anim.delegate = delegate;
    
    [layer addAnimation:move_anim forKey:@"position"];
    
    return move_anim;
}

@end
