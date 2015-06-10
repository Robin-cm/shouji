//
//  ViewController.m
//  shouji
//
//  Created by 常敏 on 15-3-23.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

#define kDatabaseName @"database.sqlite3"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.email resignFirstResponder];
}


#pragma mark - Actions
/*
    存储结果
 */
- (IBAction)storeResults:(id)sender {
    if ([self.firstName.text isEqualToString:@""]) {
        return;
    }
    if ([self.lastName.text isEqualToString:@""]) {
        return;
    }
    if ([self.email.text isEqualToString:@""]) {
        return;
    }
    
    NSString *csvLine = [NSString stringWithFormat:@"%@,%@,%@\n", self.firstName.text, self.lastName.text, self.email.text];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *surveyFile = [docDir stringByAppendingPathComponent:@"surveyresults.csv"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:surveyFile]){
        [[NSFileManager defaultManager] createFileAtPath:surveyFile contents:nil attributes:nil];
    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:surveyFile];
    
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[csvLine dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    
    self.firstName.text = @"";
    self.lastName.text = @"";
    self.email.text = @"";
    
}

- (IBAction)storeresultsSqlite:(id)sender {
    
}

/*
    显示结果 
 */
- (IBAction)showResults:(id)sender {
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *surveyFile = [docDir stringByAppendingPathComponent:@"surveyresults.csv"];
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:surveyFile]){
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:surveyFile];
        NSString *surveyResults = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
        self.resultsView.text = surveyResults;
    }
    
}

- (IBAction)showResultsSqlite:(id)sender {
}

#pragma mark - Functions

-(void) initDataBase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [paths objectAtIndex:0];
    
    self.databaseFilePath = [documentDir stringByAppendingPathComponent:kDatabaseName];
    
    //打开或者创建数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
    }
    
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS (TAG INTEGER PRIMARY KEY, FIRSTNAME TEXT, LASTNAME TEXT, EMAIL TEXT)";
    
    char *errorMsg;
    
    if(sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"创建数据库表错误：%s", errorMsg);
    }
    
}

@end
