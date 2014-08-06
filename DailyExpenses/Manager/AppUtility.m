//
//  AppUtility.m
//  DailyExpenses
//
//  Created by renan veloso silva on 01/06/14.
//
//

#import "AppUtility.h"

@implementation AppUtility

SynthensizeSingleTon(AppUtility)

+(NSString *)baseUrl{
    return [[DevCustomSetting sharedInstance] htmlBasePath];
}

+(NSString*)baseUrlWithAppendPath:(NSString*)path{
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",[self baseUrl],path];
    return fullPath;
}

@end
