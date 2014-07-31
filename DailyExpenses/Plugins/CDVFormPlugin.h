//
//  CDVFormPlugin.h
//  DailyExpenses
//
//  Created by renan veloso silva on 27/06/14.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface CDVFormPlugin : CDVPlugin

-(void)Populate:(CDVInvokedUrlCommand*)command;

@end
