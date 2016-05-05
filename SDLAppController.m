#import "SDLAppController.h"
#import "SDLQuadPage.h"
#import "SDLPrintView.h"

@implementation SDLAppController

- (id)init
{
    if (self = [super init])
    {
        quadPages = [[NSMutableArray alloc] init];
        pages = 0; firstPageWidth = 0; innermostPageWidth = 0; quadPagesNumber = pages / 4; copyFlag = NO;
        customer = @""; jobNumber = 0;
        now = [NSCalendarDate calendarDate];
        [now setCalendarFormat:@"%m/%d/%y"];
    }
    return self;
}

- (void)windowControllerDidLoadNib
{
    [dateField setObjectValue:now];
}

- (IBAction)updateJobNumber:(id)sender
{
    if ([[jobNumberField stringValue] length] > 5)
    {
        NSRunAlertPanel(NSLocalizedString(@"InvalidEntry", nil),
                        NSLocalizedString(@"JobNumberTooLong", nil),
                        NSLocalizedString(@"OK", nil), nil, nil, nil);
        [sender setIntValue:0];
    }
    else
        jobNumber = [sender intValue];
}

- (IBAction)updateCustomer:(id)sender
{
    customer = [sender stringValue];
}

- (IBAction)updateFields:(id)sender
{
    if ([pagesField intValue] != 0)
    {
        if (pages % 4 != 0)
        {
            NSBeep();
            NSRunAlertPanel(NSLocalizedString(@"InvalidEntry", nil),
                            NSLocalizedString(@"Mod4", nil),
                            NSLocalizedString(@"OK", nil), nil, nil, nil);
            [pagesField setIntValue:0];
        }
        pages = [pagesField intValue];
        quadPagesNumber = pages / 4;
        if ([firstPageWidthField doubleValue] != 0)
        {
            firstPageWidth = [firstPageWidthField doubleValue];
            if ([innermostPageWidthField doubleValue] != 0)
                innermostPageWidth = [innermostPageWidthField doubleValue];
        }

        [self createTable];
        [table reloadData];
    }
}

- (void)createTable
{
    int i;
    double delta = firstPageWidth - innermostPageWidth, value;

    [quadPages release];
    quadPages = [[NSMutableArray alloc] init];

    for (i = 0; i < quadPagesNumber; i++)
    {
        value = delta / (quadPagesNumber - 1) * i;
        [quadPages addObject:[[[SDLQuadPage alloc] init] setQuadPage:i
                                                        setQuadPages:quadPagesNumber
                                                    setOffsetPercent:(1 - value / firstPageWidth) * 100
                                                     setOffsetInches:value
                                                     setRealPageSize:innermostPageWidth - value]];
    }
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
    return [[quadPages objectAtIndex:rowIndex] valueForKey:[aTableColumn identifier]];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return quadPagesNumber;
}

- (IBAction)showSDLHelp:(id)sender
{
    NSRunAlertPanel(NSLocalizedString(@"SaddleHelp", nil), NSLocalizedString(@"Help", nil), NSLocalizedString(@"OK", nil), nil, nil);
}

- (IBAction)print:(id)sender
{
    NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];
    NSPrintOperation *printOp;
    SDLPrintView *view = [[SDLPrintView alloc] initWithQuadPages:quadPages printInfo:printInfo];
    [printInfo setTopMargin:72];
    printOp = [NSPrintOperation printOperationWithView:view printInfo:printInfo];
    [printOp setShowPanels:YES];
    [printOp runOperation];
    [view release];
}

//Getters
- (NSCalendarDate *)date
{
    return now;
}

- (NSString *)customer
{
    return customer;
}

- (double)firstPageWidth
{
    return firstPageWidth;
}

- (double)innermostPageWidth
{
    return innermostPageWidth;
}

- (int)jobNumber
{
    return jobNumber;
}

- (int)pages
{
    return pages;
}

- (void)dealloc
{
    [now release];
    [customer release];
    [quadPages release];
    [super dealloc];
}

@end