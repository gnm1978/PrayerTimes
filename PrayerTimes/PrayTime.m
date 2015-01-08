//--------------------- Copyright Block ----------------------
/* 

PrayTime.m: Prayer Times Calculator (ver 1.2)
Copyright (C) 2007-2010 PrayTimes.org

Objective C Code By: Hussain Ali Khan
Original JS Code By: Hamid Zarrabi-Zadeh

License: GNU LGPL v3.0

TERMS OF USE:
	Permission is granted to use this code, with or 
	without modification, in any website or application 
	provided that credit is given to the original work 
	with a link back to PrayTimes.org.

This program is distributed in the hope that it will 
be useful, but WITHOUT ANY WARRANTY. 

PLEASE DO NOT REMOVE THIS COPYRIGHT BLOCK.

*/


#import "PrayTime.h"

//---------------------- Global Variables --------------------


int calcMethod   = 0;		// caculation method
int asrJuristic  = 0;		// Juristic method for Asr
int dhuhrMinutes = 0;		// minutes after mid-day for Dhuhr
int adjustHighLats = 1;	// adjusting method for higher latitudes

int timeFormat   = 0;		// time format

double lat;        // latitude 
double lng;        // longitude 
double timeZone;   // time-zone 
double JDate;      // Julian date

//------------------------------------------------------------

@implementation PrayTime

@synthesize Jafari;
@synthesize Karachi;
@synthesize ISNA;
@synthesize MWL;
@synthesize Makkah;
@synthesize Egypt;
@synthesize Custom;
@synthesize Tehran;

@synthesize Shafii;
@synthesize Hanafi;

@synthesize None;
@synthesize MidNight;
@synthesize OneSeventh;
@synthesize AngleBased;

@synthesize Time24;
@synthesize Time12;
@synthesize Time12NS;
@synthesize Float;

@synthesize timeNames;
@synthesize InvalidTime;

@synthesize numIterations;

@synthesize methodParams;

@synthesize prayerTimesCurrent;
@synthesize offsets;

-(instancetype) init {
	self = [super init];
	
	if(self){
		// Calculation Methods
		Jafari     = 0;    // Ithna Ashari
		Karachi    = 1;    // University of Islamic Sciences, Karachi
		ISNA       = 2;    // Islamic Society of North America (ISNA)
		MWL        = 3;    // Muslim World League (MWL)
		Makkah     = 4;    // Umm al-Qura, Makkah
		Egypt      = 5;    // Egyptian General Authority of Survey
		Custom     = 7;    // Custom Setting
		Tehran     = 6;    // Institute of Geophysics, University of Tehran
		
		// Juristic Methods
		Shafii     = 0;    // Shafii (standard)
		Hanafi     = 1;    // Hanafi
		
		// Adjusting Methods for Higher Latitudes
		None       = 0;    // No adjustment
		MidNight   = 1;    // middle of night
		OneSeventh = 2;    // 1/7th of night
		AngleBased = 3;    // angle/60th of night
		
		
		// Time Formats
		Time24     = 0;    // 24-hour format
		Time12     = 1;    // 12-hour format
		Time12NS   = 2;    // 12-hour format with no suffix
		Float      = 3;    // floating ponumber
		
		// Time Names
		timeNames = [[NSMutableArray alloc] init];
		[timeNames addObject:@"Fajr"];
		[timeNames addObject:@"Sunrise"];
		[timeNames addObject:@"Dhuhr"];
		[timeNames addObject:@"Asr"];
		[timeNames addObject:@"Sunset"];
		[timeNames addObject:@"Maghrib"];
		[timeNames addObject:@"Isha"];
		
		InvalidTime = @"-----";	 // The string used for invalid times
		
		//--------------------- Technical Settings --------------------
		
		numIterations = 1;		// number of iterations needed to compute times
		
		//------------------- Calc Method Parameters --------------------
		
		//Tuning offsets
		offsets = [[NSMutableArray alloc] init];
		[offsets addObject:@0];//fajr
		[offsets addObject:@0];//sunrise
		[offsets addObject:@0];//dhuhr
		[offsets addObject:@0];//asr
		[offsets addObject:@0];//sunset
		[offsets addObject:@0];//maghrib
		[offsets addObject:@0];//isha

		/*
		 
		 fa : fajr angle
		 ms : maghrib selector (0 = angle; 1 = minutes after sunset)
		 mv : maghrib parameter value (in angle or minutes)
		 is : isha selector (0 = angle; 1 = minutes after maghrib)
		 iv : isha parameter value (in angle or minutes)
		 */
		methodParams = [[NSMutableDictionary alloc] initWithCapacity:8];
		
		NSMutableArray *Jvalues = [[NSMutableArray alloc] init];
		//Jafari
		[Jvalues addObject:@16];
		[Jvalues addObject:@0];
		[Jvalues addObject:@4];
		[Jvalues addObject:@0];
		[Jvalues addObject:@14];
		
		
		methodParams[[NSNumber numberWithInt: Jafari]] = Jvalues;
		
		
		//Karachi
		NSMutableArray *Kvalues = [[NSMutableArray alloc] init];
		[Kvalues addObject:@18];
		[Kvalues addObject:@1];
		[Kvalues addObject:@0];
		[Kvalues addObject:@0];
		[Kvalues addObject:@18];
		
		
		methodParams[[NSNumber numberWithInt: Karachi]] = Kvalues;
		
		//ISNA
		NSMutableArray *Ivalues = [[NSMutableArray alloc] init];
		[Ivalues addObject:@15];
		[Ivalues addObject:@1];
		[Ivalues addObject:@0];
		[Ivalues addObject:@0];
		[Ivalues addObject:@15];
		
		
		methodParams[[NSNumber numberWithInt: ISNA]] = Ivalues;
		
		
		//MWL
		NSMutableArray *Mvalues = [[NSMutableArray alloc] init];
		[Mvalues addObject:@18];
		[Mvalues addObject:@1];
		[Mvalues addObject:@0];
		[Mvalues addObject:@0];
		[Mvalues addObject:@17];
		
		
		methodParams[[NSNumber numberWithInt: MWL]] = Mvalues;
		
		
		//Makkah
		NSMutableArray *Mavalues = [[NSMutableArray alloc] init];
		[Mavalues addObject:@18.5];
		[Mavalues addObject:@1];
		[Mavalues addObject:@0];
		[Mavalues addObject:@1];
		[Mavalues addObject:@90];
		
		
		methodParams[[NSNumber numberWithInt: Makkah]] = Mavalues;
		
		//Egypt
		NSMutableArray *Evalues = [[NSMutableArray alloc] init];
		[Evalues addObject:@19.5];
		[Evalues addObject:@1];
		[Evalues addObject:@0];
		[Evalues addObject:@0];
		[Evalues addObject:@17.5];
		
		
		methodParams[[NSNumber numberWithInt: Egypt]] = Evalues;
		
		//Tehran
		NSMutableArray *Tvalues = [[NSMutableArray alloc] init];
		[Tvalues addObject:@17.7];
		[Tvalues addObject:@0];
		[Tvalues addObject:@4.5];
		[Tvalues addObject:@0];
		[Tvalues addObject:@14];
		
		
		methodParams[[NSNumber numberWithInt: Tehran]] = Tvalues;
		
		
		//Custom
		NSMutableArray *Cvalues = [[NSMutableArray alloc] init];
		[Cvalues addObject:@18];
		[Cvalues addObject:@1];
		[Cvalues addObject:@0];
		[Cvalues addObject:@0];
		[Cvalues addObject:@17];
		
		
		methodParams[[NSNumber numberWithInt: Custom]] = Cvalues;
		
		
	}
	return self;
}

//---------------------- Trigonometric Functions -----------------------

// range reduce angle in degrees.
-(double) fixangle: (double) a {
	
	a = a - (360 * (floor(a / 360.0)));
	
	a = a < 0 ? (a + 360) : a;
	return a;
}

// range reduce hours to 0..23
-(double) fixhour: (double) a {
	a = a - 24.0 * floor(a / 24.0);
	a = a < 0 ? (a + 24) : a;
	return a;
}

// radian to degree
-(double) radiansToDegrees:(double)alpha {
	return ((alpha*180.0)/M_PI);	
}

//deree to radian
-(double) DegreesToRadians:(double)alpha {
	return ((alpha*M_PI)/180.0);	
}

// degree sin
-(double)dsin: (double) d {
	return (sin([self DegreesToRadians:d]));
}

// degree cos
-(double)dcos: (double) d {
	return (cos([self DegreesToRadians:d]));
}

// degree tan
-(double)dtan: (double) d {
	return (tan([self DegreesToRadians:d]));
}

// degree arcsin
-(double)darcsin: (double) x {
	double val = asin(x);
	return [self radiansToDegrees: val];
}

// degree arccos
-(double)darccos: (double) x {
	double val = acos(x);
	return [self radiansToDegrees: val];
}

// degree arctan
-(double)darctan: (double) x {
	double val = atan(x);
	return [self radiansToDegrees: val];
}

// degree arctan2
-(double)darctan2: (double)y andX: (double) x {
	double val = atan2(y, x);
	return [self radiansToDegrees: val];
}

// degree arccot
-(double)darccot: (double) x {
	double val = atan2(1.0, x);
	return [self radiansToDegrees: val];
}

//---------------------- Time-Zone Functions -----------------------

// compute local time-zone for a specific date
-(double)getTimeZone {
	NSTimeZone *timeZone = [NSTimeZone localTimeZone];
	double hoursDiff = [timeZone secondsFromGMT]/3600.0f;
	return hoursDiff;
}

// compute base time-zone of the system
-(double)getBaseTimeZone {
	
	NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
	double hoursDiff = [timeZone secondsFromGMT]/3600.0f;
	return hoursDiff;
	
}

// detect daylight saving in a given date
-(double)detectDaylightSaving {
	NSTimeZone *timeZone = [NSTimeZone localTimeZone];
	double hoursDiff = [timeZone daylightSavingTimeOffsetForDate:[NSDate date]];
	return hoursDiff;
}

//---------------------- Julian Date Functions -----------------------

// calculate julian date from a calendar date
-(double) julianDate: (int)year andMonth:(int)month andDay:(int)day {
	
	if (month <= 2) 
	{
		year -= 1;
		month += 12;
	}
	double A = floor(year/100.0);
	
	double B = 2 - A + floor(A/4.0);
	
	double JD = floor(365.25 * (year+ 4716)) + floor(30.6001 * (month + 1)) + day + B - 1524.5;
		
	return JD;
}


// convert a calendar date to julian date (second method)
-(double)calcJD: (int)year andMonth:(int)month andDay:(int)day {
	double J1970 = 2440588;
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setWeekday:day]; // Monday
	//[components setWeekdayOrdinal:1]; // The first day in the month
	[components setMonth:month]; // May
	[components setYear:year];
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDate *date1 = [gregorian dateFromComponents:components];
	
	double ms = [date1 timeIntervalSince1970];// # of milliseconds since midnight Jan 1, 1970
	double days = floor(ms/ (1000.0 * 60.0 * 60.0 * 24.0)); 
	return J1970+ days- 0.5;
}

//---------------------- Calculation Functions -----------------------

// References:
// http://www.ummah.net/astronomy/saltime  
// http://aa.usno.navy.mil/faq/docs/SunApprox.html


// compute declination angle of sun and equation of time
-(NSMutableArray*)sunPosition: (double) jd {
	
	double D = jd - 2451545;
	double g = [self fixangle: (357.529 + 0.98560028 * D)];
	double q = [self fixangle: (280.459 + 0.98564736 * D)];
	double L = [self fixangle: (q + (1.915 * [self dsin: g]) + (0.020 * [self dsin:(2 * g)]))];
	
	//double R = 1.00014 - 0.01671 * [self dcos:g] - 0.00014 * [self dcos: (2*g)];
	double e = 23.439 - (0.00000036 * D);
	double d = [self darcsin: ([self dsin: e] * [self dsin: L])];
	double RA = ([self darctan2: ([self dcos: e] * [self dsin: L]) andX: [self dcos:L]])/ 15.0;
	RA = [self fixhour:RA];
	
	double EqT = q/15.0 - RA;
	
	NSMutableArray *sPosition = [[NSMutableArray alloc] init];
	[sPosition addObject:@(d)];
	[sPosition addObject:@(EqT)];
	
	return sPosition;
}

// compute equation of time
-(double)equationOfTime: (double)jd {
	double eq = [[self sunPosition:jd][1] doubleValue];
	return eq;
}

// compute declination angle of sun
-(double)sunDeclination: (double)jd {
	double d = [[self sunPosition:jd][0] doubleValue];
	return d;
}

// compute mid-day (Dhuhr, Zawal) time
-(double)computeMidDay: (double) t {
	double T = [self equationOfTime:(JDate+ t)];
	double Z = [self fixhour: (12 - T)];
	return Z;
}

// compute time for a given angle G
-(double)computeTime: (double)G andTime: (double)t {
	
	double D = [self sunDeclination:(JDate+ t)];
	double Z = [self computeMidDay: t];
	double V = ([self darccos: (-[self dsin:G] - ([self dsin:D] * [self dsin:lat]))/ ([self dcos:D] * [self dcos:lat])]) / 15.0f;

	return Z+ (G>90 ? -V : V);
}

// compute the time of Asr
// Shafii: step=1, Hanafi: step=2
-(double)computeAsr: (double)step andTime:(double)t {
	double D = [self sunDeclination:(JDate+ t)];
	double G = -[self darccot : (step + [self dtan:ABS(lat-D)])];
	return [self computeTime:G andTime:t];
}

//---------------------- Misc Functions -----------------------


// compute the difference between two times 
-(double)timeDiff:(double)time1 andTime2:(double) time2 {
	return [self fixhour: (time2- time1)];
}

//-------------------- Interface Functions --------------------


// return prayer times for a given date
-(NSMutableArray*)getDatePrayerTimes:(int)year andMonth:(int)month andDay:(int)day andLatitude:(double)latitude andLongitude:(double)longitude andtimeZone:(double)tZone {
	lat = latitude;
	lng = longitude; 
	
	//timeZone = this.effectiveTimeZone(year, month, day, timeZone); 
	//timeZone = [self getTimeZone];
	timeZone = tZone;
	JDate = [self julianDate:year andMonth:month andDay:day];
	
	double lonDiff = longitude/(15.0 * 24.0);
	JDate = JDate - lonDiff;
	return [self computeDayTimes];
}

// return prayer times for a given date
-(NSMutableArray*)getPrayerTimes: (NSDateComponents*)date andLatitude:(double)latitude andLongitude:(double)longitude andtimeZone:(double)tZone {
	
	NSInteger year = [date year];
	NSInteger month = [date month];
	NSInteger day = [date day];
	return [self getDatePrayerTimes:year andMonth:month andDay:day andLatitude:latitude andLongitude:longitude andtimeZone:tZone];
}

// set the calculation method 
-(void)setCalcMethod: (int)methodID {
	calcMethod = methodID;
}

// set the juristic method for Asr
-(void)setAsrMethod: (int)methodID {
	if (methodID < 0 || methodID > 1)
		return;
	asrJuristic = methodID;
}

// set custom values for calculation parameters
-(void)setCustomParams: (NSMutableArray*)params {
	int i;
	id j;
	id Cust = methodParams[@((int)Custom)];
	id cal = methodParams[@(calcMethod)];
	for (i=0; i<5; i++)
	{
		j = params[i];
		if ([j isEqualToNumber: @-1])			
			Cust[i] = cal[i] ;
		
		else
			Cust[i] = params[i];
	}
	calcMethod = Custom;
}

// set the angle for calculating Fajr
-(void)setFajrAngle:(double)angle {
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:@(angle)];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[self setCustomParams:params];
}

// set the angle for calculating Maghrib
-(void)setMaghribAngle:(double)angle {
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:@-1.0];
	[params addObject:@0.0];
	[params addObject:@(angle)];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[self setCustomParams:params];
}

// set the angle for calculating Isha
-(void)setIshaAngle:(double)angle {
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[params addObject:@0.0];
	[params addObject:@(angle)];
	[self setCustomParams:params];
}

// set the minutes after mid-day for calculating Dhuhr
-(void)setDhuhrMinutes:(double)minutes {
	dhuhrMinutes = minutes;
}

// set the minutes after Sunset for calculating Maghrib
-(void)setMaghribMinutes:(double)minutes {
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:@-1.0];
	[params addObject:@1.0];
	[params addObject:@(minutes)];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[self setCustomParams:params];
}

// set the minutes after Maghrib for calculating Isha
-(void)setIshaMinutes:(double)minutes {
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[params addObject:@-1.0];
	[params addObject:@1.0];
	[params addObject:@(minutes)];
	[self setCustomParams:params];
}

// set adjusting method for higher latitudes 
-(void)setHighLatsMethod:(int)methodID {
	adjustHighLats = methodID;
}

// set the time format 
-(void)setTimeFormat: (int)tFormat {
	timeFormat = tFormat;
}

// convert double hours to 24h format
-(NSString*)floatToTime24:(double)time {
	
	NSString *result = nil;
	
	if (isnan(time))
		return InvalidTime;
	
	time = [self fixhour:(time + 0.5/ 60.0)];  // add 0.5 minutes to round
	int hours = floor(time); 
	double minutes = floor((time - hours) * 60.0);
	
	if((hours >=0 && hours<=9) && (minutes >=0 && minutes <=9)){
		result = [NSString stringWithFormat:@"0%d:0%.0f",hours, minutes];
	}
	else if((hours >=0 && hours<=9)){
		result = [NSString stringWithFormat:@"0%d:%.0f",hours, minutes];
	}
	else if((minutes >=0 && minutes <=9)){
		result = [NSString stringWithFormat:@"%d:0%.0f",hours, minutes];
	}
	else{
		result = [NSString stringWithFormat:@"%d:%.0f",hours, minutes];
	}
	return result;
}

// convert double hours to 12h format
-(NSString*)floatToTime12:(double)time andnoSuffix:(BOOL)noSuffix {
	
	if (isnan(time))
		return InvalidTime;
	
	time =[self fixhour:(time+ 0.5/ 60)];  // add 0.5 minutes to round
	double hours = floor(time); 
	double minutes = floor((time- hours)* 60);
	NSString *suffix, *result=nil;
	if(hours >= 12) {
		suffix = @"pm";
	}
	else{
		suffix = @"am";
	}
	//hours = ((((hours+ 12) -1) % (12))+ 1);
	hours = (hours + 12) - 1;
	int hrs = (int)hours % 12;
	hrs += 1;
	if(noSuffix == NO){
		if((hrs >=0 && hrs<=9) && (minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"0%d:0%.0f %@",hrs, minutes, suffix];
		}
		else if((hrs >=0 && hrs<=9)){
			result = [NSString stringWithFormat:@"0%d:%.0f %@",hrs, minutes, suffix];
		}
		else if((minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"%d:0%.0f %@",hrs, minutes, suffix];
		}
		else{
			result = [NSString stringWithFormat:@"%d:%.0f %@",hrs, minutes, suffix];
		}
		
	}
	else{
		if((hrs >=0 && hrs<=9) && (minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"0%d:0%.0f",hrs, minutes];
		}
		else if((hrs >=0 && hrs<=9)){
			result = [NSString stringWithFormat:@"0%d:%.0f",hrs, minutes];
		}
		else if((minutes >=0 && minutes <=9)){
			result = [NSString stringWithFormat:@"%d:0%.0f",hrs, minutes];
		}
		else{
			result = [NSString stringWithFormat:@"%d:%.0f",hrs, minutes];
		}
	}
	return result;
	
}

// convert double hours to 12h format with no suffix
-(NSString*)floatToTime12NS:(double)time {
	return [self floatToTime12:time andnoSuffix:YES];
}

//---------------------- Compute Prayer Times -----------------------


// compute prayer times at given julian date
-(NSMutableArray*)computeTimes:(NSMutableArray*)times {
	
	NSMutableArray *t = [self dayPortion:times];
	
	id obj = methodParams[@(calcMethod)];
	double idk = [obj[0] doubleValue];
	double Fajr    = [self computeTime:(180 - idk) andTime: [t[0] doubleValue]];
	double Sunrise = [self computeTime:(180 - 0.833) andTime: [t[1] doubleValue]];
	double Dhuhr   = [self computeMidDay: [t[2] doubleValue]];
	double Asr     = [self computeAsr:(1 + asrJuristic) andTime: [t[3] doubleValue]];
	double Sunset  = [self computeTime:0.833 andTime: [t[4] doubleValue]];
	double Maghrib = [self computeTime:[methodParams[@(calcMethod)][2] doubleValue] andTime: [t[5] doubleValue]];
	double Isha    = [self computeTime:[methodParams[@(calcMethod)][4] doubleValue] andTime: [t[6] doubleValue]];
	
	NSMutableArray *Ctimes = [[NSMutableArray alloc] init];
	[Ctimes addObject:@(Fajr)];
	[Ctimes addObject:@(Sunrise)];
	[Ctimes addObject:@(Dhuhr)];
	[Ctimes addObject:@(Asr)];
	[Ctimes addObject:@(Sunset)];
	[Ctimes addObject:@(Maghrib)];
	[Ctimes addObject:@(Isha)];
	
	
	//Tune times here
	//Ctimes = [self tuneTimes:Ctimes];
	
	return Ctimes;
}

// compute prayer times at given julian date
-(NSMutableArray*)computeDayTimes {
	
	//int i = 0;
	NSMutableArray *t1, *t2, *t3;
	NSMutableArray *times = [[NSMutableArray alloc] init]; //default times
	[times addObject:@5.0];
	[times addObject:@6.0];
	[times addObject:@12.0];
	[times addObject:@13.0];
	[times addObject:@18.0];
	[times addObject:@18.0];
	[times addObject:@18.0];
	
	for (int i=1; i<= numIterations; i++)  
		t1 = [self computeTimes:times];
	
	t2 = [self adjustTimes:t1];
	
	t2 = [self tuneTimes:t2];
	
	//Set prayerTimesCurrent here!!
	prayerTimesCurrent = [[NSMutableArray alloc] initWithArray:t2];
	
	t3 = [self adjustTimesFormat:t2];
	
	
	
	return t3;
}

//Tune timings for adjustments
//Set time offsets
-(void)tune:(NSMutableDictionary*)offsetTimes{

	offsets[0] = offsetTimes[@"fajr"];
	offsets[1] = offsetTimes[@"sunrise"];
	offsets[2] = offsetTimes[@"dhuhr"];
	offsets[3] = offsetTimes[@"asr"];
	offsets[4] = offsetTimes[@"sunset"];
	offsets[5] = offsetTimes[@"maghrib"];
	offsets[6] = offsetTimes[@"isha"];
}

-(NSMutableArray*)tuneTimes:(NSMutableArray*)times{
	double off, time;
	for(int i=0; i<[times count]; i++){
		//if(i==5)
		//NSLog(@"Normal: %d - %@", i, [times objectAtIndex:i]);
		off = [offsets[i] doubleValue]/60.0;
		time = [times[i] doubleValue] + off;
		times[i] = @(time);
		//if(i==5)
		//NSLog(@"Modified: %d - %@", i, [times objectAtIndex:i]);
	}
	
	return times;
}

// adjust times in a prayer time array
-(NSMutableArray*)adjustTimes:(NSMutableArray*)times {
	
	int i = 0;
	NSMutableArray *a; //test variable
	double time = 0, Dtime, Dtime1, Dtime2;
	
	for (i=0; i<7; i++) {
		time = ([times[i] doubleValue]) + (timeZone- lng/ 15.0);
		
		times[i] = @(time);
		
	}
	
	Dtime = [times[2] doubleValue] + (dhuhrMinutes/ 60.0); //Dhuhr
		
	times[2] = @(Dtime);
	
	a = methodParams[@(calcMethod)];
	double val = [a[1] doubleValue];
	
	if (val == 1) { // Maghrib
		Dtime1 = [times[4] doubleValue]+ ([methodParams[@(calcMethod)][2] doubleValue]/60.0);
		times[5] = @(Dtime1);
	}
	
	if ([methodParams[@(calcMethod)][3] doubleValue]== 1) { // Isha
		Dtime2 = [times[5] doubleValue] + ([methodParams[@(calcMethod)][4] doubleValue]/60.0);
		times[6] = @(Dtime2);
	}
	
	if (adjustHighLats != None){
		times = [self adjustHighLatTimes:times];
	}
	return times;
}


// convert times array to given time format
-(NSMutableArray*)adjustTimesFormat:(NSMutableArray*)times {
	int i = 0;
	
	if (timeFormat == Float){
		return times;
	}
	for (i=0; i<7; i++) {
		if (timeFormat == Time12){
			times[i] = [self floatToTime12:[times[i] doubleValue] andnoSuffix:NO];
		}
		else if (timeFormat == Time12NS){
			times[i] = [self floatToTime12:[times[i] doubleValue] andnoSuffix:YES];
		}
		else{
			
			times[i] = [self floatToTime24:[times[i] doubleValue]];
		}
	}
	return times;
}


// adjust Fajr, Isha and Maghrib for locations in higher latitudes
-(NSMutableArray*)adjustHighLatTimes:(NSMutableArray*)times {
	
	double time0 = [times[0] doubleValue];
	double time1 = [times[1] doubleValue];
	//double time2 = [[times objectAtIndex:2] doubleValue];
	//double time3 = [[times objectAtIndex:3] doubleValue];
	double time4 = [times[4] doubleValue];
	double time5 = [times[5] doubleValue];
	double time6 = [times[6] doubleValue];
	
	double nightTime = [self timeDiff:time4 andTime2:time1]; // sunset to sunrise
	
	// Adjust Fajr
	double obj0 =[methodParams[@(calcMethod)][0] doubleValue];
	double obj1 =[methodParams[@(calcMethod)][1] doubleValue];
	double obj2 =[methodParams[@(calcMethod)][2] doubleValue];
	double obj3 =[methodParams[@(calcMethod)][3] doubleValue];
	double obj4 =[methodParams[@(calcMethod)][4] doubleValue];
	
	double FajrDiff = [self nightPortion:obj0] * nightTime;
	
	if ((isnan(time0)) || ([self timeDiff:time0 andTime2:time1] > FajrDiff)) 
		times[0] = @(time1 - FajrDiff);
	
	// Adjust Isha
	double IshaAngle = (obj3 == 0) ? obj4: 18;
	double IshaDiff = [self nightPortion: IshaAngle] * nightTime;
	if (isnan(time6) ||[self timeDiff:time4 andTime2:time6] > IshaDiff) 
		times[6] = @(time4 + IshaDiff);
	
	
	// Adjust Maghrib
	double MaghribAngle = (obj1 == 0) ? obj2 : 4;
	double MaghribDiff = [self nightPortion: MaghribAngle] * nightTime;
	if (isnan(time5) || [self timeDiff:time4 andTime2:time5] > MaghribDiff) 
		times[5] = @(time4 + MaghribDiff);
	
	return times;
}


// the night portion used for adjusting times in higher latitudes
-(double)nightPortion:(double)angle {
	double calc = 0;
	
	if (adjustHighLats == AngleBased)
		calc = (angle)/60.0f;
	else if (adjustHighLats == MidNight)
		calc = 0.5f;
	else if (adjustHighLats == OneSeventh)
		calc = 0.14286f;
	
	return calc;
}


// convert hours to day portions 
-(NSMutableArray*)dayPortion:(NSMutableArray*)times {
	int i = 0;
	double time = 0;
	for (i=0; i<7; i++){
		time = [times[i] doubleValue];
		time = time/24.0;
		
		times[i] = @(time);
		
	}
	return times;
}



@end