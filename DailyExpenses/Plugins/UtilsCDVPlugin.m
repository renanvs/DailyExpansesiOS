//
//  UtilsCDVPlugin.m
//  DailyExpenses
//
//  Created by renan veloso silva on 22/05/14.
//
//

#import "UtilsCDVPlugin.h"

@implementation UtilsCDVPlugin

-(void)TestCordova:(CDVInvokedUrlCommand*)command{
    CDVPluginResult *result = nil;
    
    NSString *msg = [[command arguments] lastObject];
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}


@end
