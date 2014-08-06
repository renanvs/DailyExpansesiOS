//
//  AppUtility.h
//  DailyExpenses
//
//  Created by renan veloso silva on 01/06/14.
//
//

#import <Foundation/Foundation.h>

@interface AppUtility : NSObject

+(id)sharedInstance;

+(NSString*)baseUrl;

+(NSString*)baseUrlWithAppendPath:(NSString*)path;

@end
