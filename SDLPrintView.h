//
//  SDLPrintView.h
//  Saddle
//
//  Created by Alan Aversa on Sun Aug 18 2002.
//  Copyright (c) 2001 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>


@interface SDLPrintView : NSView {
    NSArray *quadPages;
    int quadPagesPerPage;
    int pages;
    float rectHeight;
}
- initWithQuadPages:(NSArray *)array printInfo:(NSPrintInfo *)pi;
- (NSRect)rectForQuadPage:(int)index;

@end
