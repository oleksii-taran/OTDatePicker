//
//  OTDatePicker.m
//  CalendarView
//
//  Created by Oleksii Taran on 1/16/14.
//  Copyright (c) 2014 Oleksii Taran. All rights reserved.
//

#import "OTDatePicker.h"
#import "__OTDatePicker.h"
#import "OTDatePickerDayCell.h"


@interface OTDatePicker () <
	UICollectionViewDataSource,
	UICollectionViewDelegate
>

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
	
	contentView.daysCollectionView.dataSource = self;
	contentView.daysCollectionView.delegate = self;
	[contentView.daysCollectionView registerNib:[UINib nibWithNibName:@"OTDatePickerDayCell" bundle:nil] forCellWithReuseIdentifier:@"Day cell"];
	
	[self addSubview:contentView];
	self.contentView = contentView;
}

- (void)updateUI
{
	NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
	NSDateComponents *components = [self.effectiveCalendar components:units fromDate:self.date];
	NSInteger const year = components.year;
	NSInteger const month = components.month;
	self.contentView.yearTextField.text = [NSString stringWithFormat:@"%li", (long)year];
	self.contentView.monthTextField.text = self.dateFormatter.standaloneMonthSymbols[month - 1];
	
	[self.contentView.daysCollectionView reloadData];
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

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	NSRange range = [self.effectiveCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.date];
	return range.length;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	OTDatePickerDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Day cell" forIndexPath:indexPath];
	cell.dayLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row + 1];
	
	NSDateComponents *components = [self.effectiveCalendar components:NSCalendarUnitDay fromDate:self.date];
	if (components.day == indexPath.row + 1) {
		cell.dayLabel.backgroundColor = [UIColor redColor];
	}
	
	return cell;
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSDateComponents *components = [self.effectiveCalendar components:NSCalendarUnitDay fromDate:self.date];
	components.day = indexPath.row + 1 - components.day;
	self.date = [self.effectiveCalendar dateByAddingComponents:components toDate:self.date options:0];
	[self updateUI];
}

#pragma mark - IBActions

- (void)selectNextMonth:(id)sender
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.month = 1;
	self.date = [self.effectiveCalendar dateByAddingComponents:components toDate:self.date options:0];
	[self updateUI];
}

- (void)selectPreviousMonth:(id)sender
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.month = -1;
	self.date = [self.effectiveCalendar dateByAddingComponents:components toDate:self.date options:0];
	[self updateUI];
}

@end
