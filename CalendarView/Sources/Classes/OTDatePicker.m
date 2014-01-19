//
//  OTDatePicker.m
//  CalendarView
//
//  Created by Oleksii Taran on 1/16/14.
//  Copyright (c) 2014 Oleksii Taran. All rights reserved.
//

#import "OTDatePicker.h"
#import "__OTDatePicker.h"


@interface OTDatePicker ()

@property (nonatomic, strong) __OTDatePicker *contentView;

@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end


@implementation OTDatePicker

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.date = [NSDate date];
		
		[self loadContentView];
		[self updateUI];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.date = [NSDate date];
		
		[self loadContentView];
		[self updateUI];
	}
	return self;
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
	// TODO: implement animation
	self.date = date;
}

#pragma mark -

- (void)loadContentView
{
	NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"OTDatePicker" owner:nil options:nil];
	__OTDatePicker *contentView = [objects lastObject];
	contentView.frame = self.bounds;
	[self addSubview:contentView];
	self.contentView = contentView;
}

- (void)updateUI
{
	NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
	NSDateComponents *components = [self.effectiveCalendar components:units fromDate:self.date];
	NSInteger const year = components.year;
	NSInteger const month = components.month;
	self.contentView.yearTextField.text = [NSString stringWithFormat:@"%li", year];
	self.contentView.monthTextField.text = self.dateFormatter.standaloneMonthSymbols[month - 1];
}

- (NSCalendar *)effectiveCalendar
{
	return (self.calendar) ? : [NSCalendar currentCalendar];
}

- (NSLocale *)effectiveLocale
{
	return (self.locale) ? : ((self.calendar.locale) ? : [NSLocale currentLocale]);
}

- (NSTimeZone *)effectiveTimeZone
{
	return (self.timeZone) ? : ((self.calendar.timeZone) ? : [NSTimeZone defaultTimeZone]);
}

#pragma mark -

- (NSDateFormatter *)dateFormatter
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.calendar = self.effectiveCalendar;
	dateFormatter.locale = self.effectiveLocale;
	dateFormatter.timeZone = self.effectiveTimeZone;
	return dateFormatter;
}

#pragma mark - IBActions

- (void)selectNextMonth:(id)sender
{
	
}

- (void)selectPreviousMonth:(id)sender
{
	
}

@end
