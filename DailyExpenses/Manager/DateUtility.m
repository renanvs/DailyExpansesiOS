//
//  DateUtility.m
//  DailyExpenses
//
//  Created by renan veloso silva on 25/05/14.
//
//

#import "DateUtility.h"

@implementation DateUtility

SynthensizeSingleTon(DateUtility)


-(NSString*)getCurrentDateWithFormat:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:[NSDate date]];
}
-(NSString*)getCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSDate*)getCurrentDateN{
    return [NSDate date];
}

-(NSDate*)getDateWithStringDate:(NSString*)dateStr{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    if (dateStr.length > 10) {
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [fm setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate* date = [fm dateFromString:dateStr];
    return date;
}

-(NSString*)getDateStringWithDate:(NSDate*)date AndFormat:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

-(NSString*)getCurrentDateWithHours{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString*)getDayBefore:(NSString*)currentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateComponents *component = [[NSDateComponents alloc] init];
    [component setDay:-1];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *currentDay= [formatter dateFromString:currentDate];
    NSDate *dayBefore = [[NSCalendar currentCalendar] dateByAddingComponents:component toDate:currentDay options:0];
    return [formatter stringFromDate:dayBefore];
}

-(NSString*)getDayAfter:(NSString*)currentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateComponents *component = [[NSDateComponents alloc] init];
    [component setDay:+1];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *currentDay= [formatter dateFromString:currentDate];
    NSDate *dayAfter = [[NSCalendar currentCalendar] dateByAddingComponents:component toDate:currentDay options:0];
    return [formatter stringFromDate:dayAfter];
}

-(NSString*)getMonthByDate:(NSString*)dateS{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate* dateFromString = [dateFormatter dateFromString:dateS];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:dateFromString];
    
    NSInteger monthIndex = [components month];
    NSArray *monthList = [self getMonthList];
    NSString* monthStr = [monthList objectAtIndex:(monthIndex-1)];
    return monthStr;
}

-(NSString*)getYearByDate:(NSString*)dateS{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate* dateFromString = [dateFormatter dateFromString:dateS];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:dateFromString];
    
    NSInteger YearInt = [components year];
    NSString* YearStr = [NSString stringWithFormat:@"%ld",(long)YearInt];
    return YearStr;
}

-(NSArray*)getMonthList{
    return [NSArray arrayWithObjects:
                      @"janeiro",
                      @"fevereiro",
                      @"março",
                      @"abril",
                      @"maio",
                      @"junho",
                      @"julho",
                      @"agosto",
                      @"setembro",
                      @"outubro",
                      @"novembro",
                      @"dezembro",nil];
}


@end
