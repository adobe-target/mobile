//
//  SecondViewController.m
//  AdobeMobile
//
//  Created by parthasa on 3/13/17.
//  Copyright © 2017 parthasa. All rights reserved.
//

#import "XTViewController.h"
#import "ADBMobile.h"

@interface XTViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *memberLevel;
@end

@implementation XTViewController

- (void)viewDidLoad {
    [self XTActivity];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)XTActivity {

/*
    // Assign a random member level and reset user
    NSArray *levels = [NSArray arrayWithObjects: @"canyon", @"river", @"beach", @"mountain", nil];
    NSString *randomLevel = [levels objectAtIndex:arc4random()%[levels count]];
    NSLog(@"Your activity type is %@", randomLevel);
    [ADBMobile targetClearCookies];
    
    // Set the member level as a mbox parameter
    NSDictionary *targetParams = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  randomLevel, @"profile.memberLevel",
                                  nil];
    
     // Here 'a1-L750-xt' is the name of the location. This will show up in the content
     // location dropdown in the UI.

    // Replace a1 with your unique user number.

     ADBTargetLocationRequest* locationRequest = [ADBMobile targetCreateRequestWithName:@"a1-750-xt"
                                                                        defaultContent:@"Hello there!"
                                                                            parameters:targetParams];
    
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content){
        [self performSelectorOnMainThread:@selector(XTActivityChanges:) withObject:content waitUntilDone:YES];
    }];
 */
    
}
-(void)XTActivityChanges: (NSString*) content {
    // Treat content as JSON-encoded string
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    
    if(err) {
        NSLog(@"Unable to parse JSON message \"%@\", treating as string", content);
        [self XTActivityChangesDefault:content];
        return;
    }
    
    
    NSDictionary *parsedDict = jsonObject;
    NSString *urlText = [parsedDict objectForKey:@"url"];
    NSString *imageSelect = [parsedDict objectForKey:@"image"];
    
    if(urlText && [urlText isKindOfClass:[NSString class]]) {
        NSURL *imageUrl = [NSURL URLWithString:urlText];
        if(imageUrl) {
            NSURLSession *session = [NSURLSession sharedSession];
            
            [[session dataTaskWithURL:imageUrl
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _memberLevel.image = [UIImage imageWithData:data];
                        });
                    }] resume];
        }
    }
    
    if(imageSelect && [imageSelect isKindOfClass:[NSString class]]) {
        if([imageSelect isEqualToString:@"mountain1"]) {
            _imageView.image = [UIImage imageNamed:@"mountain1.jpg"];
        } else if([imageSelect isEqualToString:@"river1"]) {
            _imageView.image = [UIImage imageNamed:@"river1.jpg"];
        } else if([imageSelect isEqualToString:@"canyon1"]) {
            _imageView.image = [UIImage imageNamed:@"canyon1.jpg"];
        } else if([imageSelect isEqualToString:@"beach1"]) {
            _imageView.image = [UIImage imageNamed:@"beach1.jpg"];
        }
        else {
            // Do nothing.
        }
    }

}

-(void)XTActivityChangesDefault: (NSString*) content {
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray* matches = [detector matchesInString:content options:0
                                           range:NSMakeRange(0, [content length])];
    for (NSTextCheckingResult *match in matches) {
        NSURL *imageUrl = [match URL];
        
        NSURLSession *session = [NSURLSession sharedSession];

        [[session dataTaskWithURL:imageUrl
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    _memberLevel.image = [UIImage imageWithData:data];
                }] resume];
    }
}
@end

