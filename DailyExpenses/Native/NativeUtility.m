//
//  NativeUtility.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "NativeUtility.h"

@implementation NativeUtility

SynthensizeSingleTon(NativeUtility)

+(NSArray*)getParcelList{
    return [[NSArray alloc] initWithObjects:@"1x", @"2x", @"3x", @"4x", @"5x", @"6x", @"7x", @"8x",
                  @"9x", @"10x", @"11x", @"12x", @"13x", @"14x", @"15x",
                  @"16x", @"17x", @"18x", @"19x", @"20x", @"21x", @"22x",
                  @"23x", @"24x", nil];
    
}

-(void)removeElementsFromView:(UIView*)viewR{
	for (id object in [viewR subviews]) {
		[object removeFromSuperview];
	}
}

#pragma mark - setItem position

- (void)setItem:(UIView*)subView inCenterView:(UIView*)viewR padLeft:(CGFloat)l  padTop:(CGFloat)t padRight:(CGFloat)r padBottom:(CGFloat)b{
    CGRect CGItem = subView.frame;
    CGRect CGView = viewR.frame;
    
    CGFloat w = CGItem.size.width;
    CGFloat h = CGItem.size.height;
    CGFloat x = (CGView.size.width/2) - (CGItem.size.width/2) + l - r;
    CGFloat y = (CGView.size.height/2) - (CGItem.size.height/2) + t - b;
    
    CGRect newRect = CGRectMake(x, y, w, h);
    
    subView.frame = newRect;
    
}

- (void)setItem:(UIView*)subView inView:(UIView*)viewR side:(NSString*)side UpDown:(NSString*)updown padLeft:(CGFloat)l  padTop:(CGFloat)t padRight:(CGFloat)r padBottom:(CGFloat)b{
    CGRect CGItem = subView.frame;
    CGRect CGView = viewR.frame;
    
    CGFloat newX;
    CGFloat newY;
    
    if([updown isEqualToString:@"up"]){
        newY = CGView.origin.y - CGItem.size.height + t - b;
    }else{
        newY = CGView.origin.y + CGView.size.height + t - b;
    }
    
    if([side isEqualToString:@"left"]){
        newX = CGView.origin.x +l - r;
    }else{
        newX = CGView.origin.x + CGView.size.width - CGItem.size.width + l - r;
    }
    
    CGRect newRect = CGRectMake(newX, newY, CGItem.size.width, CGItem.size.height);
    
    subView.frame = newRect;
    
}

@end
