//
//  DateUtility.h
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import <Foundation/Foundation.h>

@interface DateUtility : NSObject

+(id)sharedInstance;

-(NSString*)getCurrentDate;
-(NSDate*)getCurrentDateN;
-(NSDate*)getDateWithStringDate:(NSString*)dateStr;
-(NSString*)getDateStringWithDate:(NSDate*)date AndFormat:(NSString*)format;


-(NSString*)getDayBefore:(NSString*)currentDate;
-(NSString*)getDayAfter:(NSString*)currentDate;
-(NSString*)getMonthByDate:(NSString*)dateS;
-(NSString*)getYearByDate:(NSString*)dateS;
-(NSString*)getCurrentDateWithHours;
-(NSString*)getCurrentDateWithFormat:(NSString*)format;

@end
