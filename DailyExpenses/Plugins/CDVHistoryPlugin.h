//
//  CDVHistoryPlugin.h
//  DailyExpenses
//
//  Created by renan veloso silva on 19/06/14.
//
//

#import <Cordova/CDV.h>

@interface CDVHistoryPlugin : CDVPlugin

-(void)GetAllItens:(CDVInvokedUrlCommand*)command;

@end
