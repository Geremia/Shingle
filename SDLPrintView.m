//
//  SDLPrintView.m
//  Saddle
//
//  Created by Alan Aversa on Sun Aug 18 2002.
//  Copyright (c) 2001 __MyCompanyName__. All rights reserved.
//

#import "SDLPrintView.h"
#import "SDLQuadPage.h"
#import "SDLAppController.h"


@implementation SDLPrintView

- initWithQuadPages:(NSArray *)array printInfo:(NSPrintInfo *)pi
{
    NSRect theFrame;
    NSSize paperSize;
    quadPagesPerPage = 30;
    quadPages = [array retain];

    pages = [quadPages count] / quadPagesPerPage;

    if ([quadPages count] % quadPagesPerPage != 0)
        pages++;

    paperSize = [pi paperSize];
    theFrame.origin = NSMakePoint(0,0);
    theFrame.size.width = paperSize.width;
    theFrame.size.height = paperSize.height * pages;

    self = [super initWithFrame:theFrame];

    rectHeight = paperSize.height / quadPagesPerPage;
    return self;
}

- (BOOL)knowsPageRange:(NSRange *)rptr
{
    rptr->location = 1;
    rptr->length = pages;
    return YES;
}

- (NSRect)rectForQuadPage:(int)index
{
    NSRect theResult;
    NSRect theBounds = [self bounds];
    theResult.origin.x = theBounds.origin.x;
    theResult.size.width = theBounds.size.width;
    theResult.origin.y = NSMaxY(theBounds) - ((index + 1) * rectHeight);
    theResult.size.height = rectHeight;
    return theResult;
}

- (NSRect)rectForPage:(int)pageNum
{
    NSRect theResult;
    theResult.size.width = [self bounds].size.width;
    theResult.size.height = rectHeight * quadPagesPerPage;
    theResult.origin.x = [self bounds].origin.x;
    theResult.origin.y = NSMaxY([self bounds]) - (pageNum * theResult.size.height);
    return theResult;
}

- (void)drawRect:(NSRect)rect
{
    int i;
    NSRect aRect;
    NSMutableDictionary *attributes;
    NSString *quadPageString, *shingleString, *realPageSizeString, *percentString;
    SDLQuadPage *aQuadPage;
    NSNumberFormatter *percentFormatter, *inchesFormatter;

    percentFormatter = [[NSNumberFormatter alloc] init];
    inchesFormatter = [[NSNumberFormatter alloc] init];
    [percentFormatter setFormat:@"0.0000 %"];
    [inchesFormatter setFormat:@"0.0000 in"];

    attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[NSFont fontWithName:@"Helvetica" size:12] forKey:NSFontAttributeName];
    [attributes setObject:[NSColor blackColor] forKey:NSForegroundColorAttributeName];

    for (i = 0; i < [quadPages count]; i++)
    {
        aRect = [self rectForQuadPage:i];

        if (NSIntersectsRect(aRect, rect))
        {
            aQuadPage = [quadPages objectAtIndex:i];
            
            quadPageString = [aQuadPage quadPagesString];
            shingleString = [inchesFormatter stringForObjectValue:[NSNumber numberWithDouble:[aQuadPage offsetInches]]];
            realPageSizeString = [inchesFormatter stringForObjectValue:[NSNumber numberWithDouble:[aQuadPage realPageSize]]];
            percentString = [percentFormatter stringForObjectValue:[NSNumber numberWithDouble:[aQuadPage offsetPercent]]];
            
            aRect.origin.x = aRect.origin.x + 0.5 * 72;
            aRect.size.width = aRect.size.width - 144;
            [quadPageString drawInRect:aRect withAttributes:attributes];
            
            aRect.origin.x = aRect.origin.x + 144;
            [shingleString drawInRect:aRect withAttributes:attributes];

            aRect.origin.x = aRect.origin.x + 144;
            [realPageSizeString drawInRect:aRect withAttributes:attributes];

            aRect.origin.x = aRect.origin.x + 144;
            [percentString drawInRect:aRect withAttributes:attributes];
        }
    }
    [attributes release];
    [percentFormatter release];
    [inchesFormatter release];
}

- (void)dealloc
{
    [quadPages release];
    [super dealloc];
}

@end
