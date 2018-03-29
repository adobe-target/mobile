//
//  SecondViewController.m
//  AdobeMobile
//
//  Created by parthasa on 3/13/17.
//  Copyright © 2017 parthasa. All rights reserved.
//

#import "ATViewController.h"
#import "ADBMobile.h"

@interface ATViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *memberLevel;
@end

@implementation ATViewController

- (void)viewDidLoad {
    [self XTActivity];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)XTActivity {

/*
     // Here 'a1-L750-at' is the name of the location. This will show up in the content
     // location dropdown in the UI.

    // Replace a1 with your unique user number.

     ADBTargetLocationRequest* locationRequest = [ADBMobile targetCreateRequestWithName:@"a1-L750-at"
                                                                        defaultContent:@"Hello there!"
                                                                            parameters:nil];
    
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content){
        [self performSelectorOnMainThread:@selector(ATActivityChanges:) withObject:content waitUntilDone:YES];
    }];
*/

}
-(void)ATActivityChanges: (NSString*) content {
    // Treat content as JSON-encoded string
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    
    if(err) {
        NSLog(@"Unable to parse JSON message \"%@\", treating as string", content);
        [self ATActivityChangesDefault:content];
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
        if([imageSelect isEqualToString:@"river1"]) {
            _imageView.image = [UIImage imageNamed:@"river1.jpg"];
        } else if([imageSelect isEqualToString:@"river2"]) {
            _imageView.image = [UIImage imageNamed:@"river2.jpg"];
        } else if([imageSelect isEqualToString:@"river3"]) {
            _imageView.image = [UIImage imageNamed:@"river3.jpg"];
        } else {
            // Do Nothing
        }
    }

}

-(void)ATActivityChangesDefault: (NSString*) content {
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

