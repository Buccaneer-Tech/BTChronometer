//
//  BTChronometer.m
//  BTChronometer
//
//  Created by Michael Dominick on 8/14/15.
//  Copyright (c) 2015 Buccaneer Tech.
//

#import "BTChronometer.h"

@implementation BTChronometer

+ (BTChronometer *)sharedChronomater {
    static dispatch_once_t once;
    static BTChronometer* sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSDate *)dateFromUnformattedRailsString:(NSString *)dateString {
    return [[BTChronometer sharedChronomater] dateFromUnformattedRailsString:dateString];
}

- (NSDate *)dateFromUnformattedRailsString:(NSString *)dateString {
    NSDate *date = nil; // we return a Nil value for an error
    if ([self inputIsValid:dateString]) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
        date = [dateFormat dateFromString:dateString];
    }

    return date;
}

#pragma mark Validations

- (BOOL)inputIsValid:(NSString *)inputString {
    BOOL isValid = YES;
    if (!inputString || [inputString isKindOfClass:[NSNull class]]
        || [inputString isEqualToString:@""]) {
        isValid = NO;
        NSLog(@"BTChronometer: Your date string input is invalid!");
    }
    return isValid;
}

@end
