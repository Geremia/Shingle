/* SDLAppController */

#import <Cocoa/Cocoa.h>
@class SDLQuadPage;

@interface SDLAppController : NSObject
{
    IBOutlet NSTextField *firstPageWidthField;
    IBOutlet NSTextField *innermostPageWidthField;
    IBOutlet NSTextField *pagesField;
    IBOutlet NSTableView *table;
    IBOutlet NSTextField *jobNumberField;
    IBOutlet NSTextField *customerField;
    IBOutlet NSTextField *dateField;

    NSMutableArray *quadPages;
    int pages, quadPagesNumber, jobNumber;
    double firstPageWidth, innermostPageWidth;
    BOOL copyFlag;
    NSString *customer;
    NSCalendarDate *now;
}
- (IBAction)updateFields:(id)sender;
- (IBAction)showSDLHelp:(id)sender;
- (void)createTable;
- (IBAction)updateJobNumber:(id)sender;
- (IBAction)updateCustomer:(id)sender;
- (IBAction)print:(id)sender;

//Getters
- (NSCalendarDate *)date;
- (NSString *)customer;
- (double)firstPageWidth;
- (double)innermostPageWidth;
- (int)jobNumber;
- (int)pages;

@end
