//
//  FirstViewController.m
//  AdobeMobile
//
//  Created by parthasa on 3/13/17.
//  Copyright © 2017 parthasa. All rights reserved.
//

#import "ABViewController.h"
#import "ADBMobile.h"

@interface ABViewController ()
@end

@implementation ABViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ABActivity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)ABActivity
{

/*
    // Here 'a1-L750-ab' is the name of the location. This will show up in the content
    // location dropdown in the Target UI.
    // Replace a1 with your unique user number.
    
    ADBTargetLocationRequest* locationRequest = [ADBMobile targetCreateRequestWithName:@"a1-L750-ab"
                                                                        defaultContent:@"This is a button - CHANGE MY TEXT"
                                                                            parameters:nil];
    
    [ADBMobile targetLoadRequest:locationRequest callback:^(NSString *content){
        NSLog(@"⚡️Response from Target --- %@ ⚡️", content);
        
        // It is typically a bad practice to run on the main thread! This is just for the sample app.
        // In your production app, get this content asyncronously before the view is rendered so that the end
        // user won't see a flicker when new content is inserted or replaced.
        [self performSelectorOnMainThread:@selector(ABActivityChanges:) withObject:content waitUntilDone:YES];
        
    }];

*/
    
}
 
-(void)ABActivityChanges: (NSString*) content
{
    // Treat content as JSON-encoded string
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    
    if(err) {
        NSLog(@"Unable to parse JSON message \"%@\", treating as string", content);
        if([content isKindOfClass:[NSString class]]) {
            [_welcomeMessage setTitle: content forState: UIControlStateNormal];
        }
        return;
    }
    
    
    NSDictionary *parsedDict = jsonObject;
    NSString *buttonText = [parsedDict objectForKey:@"text"];
    NSString *imageSelect = [parsedDict objectForKey:@"image"];
    
    if(buttonText && [buttonText isKindOfClass:[NSString class]]) {
        [_welcomeMessage setTitle: buttonText forState: UIControlStateNormal];
    }
    
    if(imageSelect && [imageSelect isKindOfClass:[NSString class]]) {
        if([imageSelect isEqualToString:@"canyon1"]) {
            _imageView.image = [UIImage imageNamed:@"canyon1.jpg"];
        } else if([imageSelect isEqualToString:@"canyon2"]) {
            _imageView.image = [UIImage imageNamed:@"canyon2.jpg"];
        } else if([imageSelect isEqualToString:@"canyon3"]) {
            _imageView.image = [UIImage imageNamed:@"canyon3.jpg"];
        } else {
            // Do nothing.
        }
    }

}

@end
