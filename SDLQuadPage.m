//
//  SDLQuadPage.m
//  Saddle
//
//  Created by Alan Aversa on Sun Aug 11 2002.
//  Copyright (c) 2001 __MyCompanyName__. All rights reserved.
//

#import "SDLQuadPage.h"


@implementation SDLQuadPage

- (id)init
{
    if (self = [super init])
    {
        quadPage = 0; offsetPercent = 0; offsetInches = 0; quadPages = 0;
    }
    return self;
}

//Setters
- (void)setRealPageSize:(double)i
{
    realPageSize = i;
}

- (void)setQuadPage:(int)i
{
    quadPage = i;
}

- (void)setOffsetPercent:(double)d
{
    offsetPercent = d;
}

- (void)setOffsetInches:(double)inch
{
    offsetInches = inch;
}

- (SDLQuadPage *)setQuadPage:(int)i setQuadPages:(int)plurl setOffsetPercent:(double)d setOffsetInches:(double)inch setRealPageSize:(double)real
{
    [self setQuadPage:i];
    offsetPercent = d; offsetInches = inch; quadPages = plurl; realPageSize = real;
    return self;
}

//Getters
- (double)realPageSize
{
    return realPageSize;
}

- (int)quadPage
{
    return quadPage;
}

- (double)offsetPercent
{
    return offsetPercent;
}

- (double)offsetInches
{
    return offsetInches;
}

//QuadPageString Generator and Getter
- (NSString *)quadPagesString
{
    int a = 2 * (quadPages * 2 - quadPage) , b = 2 * quadPage + 1, c = 2 * (quadPage + 1), d = 2 * (quadPages * 2 -  quadPage) - 1;
    return [NSString stringWithFormat:@"%d - %d | %d - %d", a, b, c, d];
}

@end
