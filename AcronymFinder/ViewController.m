//
//  ViewController.m
//  AcronymFinder
//
//  Created by mugunth chandran on 1/28/16.
//  Copyright © 2016 Mugunth Chandran. All rights reserved.
//

#import "ViewController.h"
#import "AcronymSearchResponse.h"
#import "AcronymDataFetch.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *acronymTxtField;
@property (strong, nonatomic) NSArray *acronymExpansion;
@property (weak, nonatomic) IBOutlet UITableView *acronymTblView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AcronymDataFetch instance];
    self.acronymTxtField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submitBtnClicked:(id)sender {
    [self.view endEditing:YES];
    if([self.acronymTxtField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an Acronym to search" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [AcronymDataFetch fetchAcronym:self.acronymTxtField.text success:^(NSURLSessionDataTask *task, id response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if(((NSArray*)response).count > 0) {
                    AcronymSearchResponse *searchResponse = [[AcronymSearchResponse alloc] initWithDict:response[0]];
                    self.acronymExpansion = [searchResponse.searchResults mutableCopy];
                    [self.acronymTblView reloadData];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Acronym not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }
         ];
    }
}

- (void)reloadTbl {
    self.acronymExpansion = nil;
    [self.acronymTblView reloadData];
}

#pragma mark - Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self reloadTbl];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.acronymExpansion.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"acronym";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    cell.textLabel.text = self.acronymExpansion[indexPath.row][@"lf"];
    return cell;
}

#pragma mark - Alert view data source

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self reloadTbl];
}

@end
