//
//  SDLQuadPage.h
//  Saddle
//
//  Created by Alan Aversa on Sun Aug 11 2002.
//  Copyright (c) 2001 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SDLQuadPage : NSObject {
    int quadPage, quadPages;
    double offsetPercent, offsetInches, realPageSize;
}
//Setters
- (void)setRealPageSize:(double)i;
- (void)setQuadPage:(int)i;
- (void)setOffsetPercent:(double)d;
- (void)setOffsetInches:(double)inch;
- (SDLQuadPage *)setQuadPage:(int)i setQuadPages:(int)plurl setOffsetPercent:(double)d setOffsetInches:(double)inch setRealPageSize:(double)real;
//Getters
- (int)quadPage;
- (double)offsetPercent;
- (double)offsetInches;
- (double)realPageSize;
//Generator / getter
- (NSString *)quadPagesString;

@end
