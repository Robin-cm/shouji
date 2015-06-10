//
//  TelViewController.m
//  shouji
//
//  Created by 常敏 on 15-3-23.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "TelViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface TelViewController () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation TelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ABPeoplePickerNavigationController *picker;
    
    picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    [self presentModalViewController:picker animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// Called after the user has pressed cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissModalViewControllerAnimated:YES];
}

// Called after a person has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0){
    NSLog(@"选择的用户是：%@", ABRecordCopyValue(person, kABPersonFirstNameProperty));
}


// Deprecated, use predicateForSelectionOfPerson and/or -peoplePickerNavigationController:didSelectPerson: instead.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    NSLog(@"选择的用户是：%@", ABRecordCopyValue(person, kABPersonFirstNameProperty));
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}

@end
