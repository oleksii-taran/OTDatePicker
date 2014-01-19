//
//  OTDatePicker.h
//  CalendarView
//
//  Created by Oleksii Taran on 1/16/14.
//  Copyright (c) 2014 Oleksii Taran. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OTDatePicker : UIControl

@property (nonatomic, copy) NSCalendar *calendar;
@property (nonatomic, strong) NSLocale *locale;
@property (nonatomic, strong) NSTimeZone *timeZone;

@property (nonatomic, strong) NSDate *date;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end


@interface OTDatePicker ()

@property (nonatomic, copy, readonly) NSCalendar *effectiveCalendar;
@property (nonatomic, strong, readonly) NSLocale *effectiveLocale;
@property (nonatomic, strong, readonly) NSTimeZone *effectiveTimeZone;

- (IBAction)selectNextMonth:(id)sender;
- (IBAction)selectPreviousMonth:(id)sender;

@end
