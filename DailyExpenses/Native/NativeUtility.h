//
//  NativeUtility.h
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import <Foundation/Foundation.h>

@interface NativeUtility : NSObject

+(id)sharedInstance;

+(NSArray*)getParcelList;

-(void)removeElementsFromView:(UIView*)viewR;

- (void)setItem:(UIView*)subView inCenterView:(UIView*)viewR padLeft:(CGFloat)l  padTop:(CGFloat)t padRight:(CGFloat)r padBottom:(CGFloat)b;

- (void)setItem:(UIView*)subView inView:(UIView*)viewR side:(NSString*)side UpDown:(NSString*)updown padLeft:(CGFloat)l  padTop:(CGFloat)t padRight:(CGFloat)r padBottom:(CGFloat)b;

@end
