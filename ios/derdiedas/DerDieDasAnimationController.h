//
//  DerDieDasAnimationController.h
//  derdiedas
//
//  Created by Christopher Berry on 18/03/2014.
//  Copyright (c) 2014 Christopher Berry. All rights reserved.
//
//  DerDieDas is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 2 of the License, or
//  (at your option) any later version.
//
//  DerDieDas is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with DerDieDas. If not, see <http://www.gnu.org/licenses/>.

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
