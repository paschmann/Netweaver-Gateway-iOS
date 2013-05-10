//
//  taViewController.m
//  Test App
//
//  Created by Paul Aschmann on 5/9/13.
//  Copyright (c) 2013 Lithium Labs, LLC. All rights reserved.
//

#import "taViewController.h"
#import "AFNetworking.h"

@interface taViewController ()

@end

@implementation taViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) WriteData{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://xxx:xxx@yourgatewayserver.com:8000/sap/opu/odata/sap/Z_BANK_CONS/BankCollection"]];
    
    NSString *dataset = @"{\"d\":{\"city\":\"East London\",\"bank_key\":\"12340000\",\"bank_name\":\"Standard Bank East London\",\"street\":\"10 Oxford Street\",\"bank_ctry\":\"ZA\"}}";
    
    [request setHTTPBody:[dataset dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:strToken forHTTPHeaderField:@"x-csrf-token"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request , NSHTTPURLResponse *response , id JSON)
                                         {
                                             JSONText.text = [NSString stringWithFormat:@"%@", JSON];
                                         }
                                                                                        failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON)
                                         {
                                             NSLog(@"Something went wrong. %@ - %@", [error localizedDescription], JSON);
                                             JSONText.text = [NSString stringWithFormat:@"%@", JSON];
                                         }];
    
    
    [operation start];
    
}

- (IBAction) ReadData{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://xxx:xxx@yourgatewayserver.com:8000/sap/opu/odata/sap/Z_BANK_CONS/BankCollection?$filter=bank_ctry%20eq%20%27ZA%27&$format=json"]];
    
    [request setValue:@"fetch" forHTTPHeaderField:@"x-csrf-token"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request , NSHTTPURLResponse *response , id JSON)
                                         {
                                             strToken = [[response allHeaderFields] valueForKeyPath:@"x-csrf-token"];
                                             NSLog(@"%@", strToken);
                                             NSLog(@"Got JSON: %@", JSON);
                                             JSONText.text = [NSString stringWithFormat:@"%@", JSON];
                                         }
                                                                                        failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON)
                                         {
                                             NSLog(@"Something went wrong. %@ - %@", [error localizedDescription], JSON);
                                             JSONText.text = [NSString stringWithFormat:@"%@", JSON];
                                         }];
    
    [operation start];
}

@end
