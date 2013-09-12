//
//  D1EditPostViewController.m
//  CFPosts
//
//  Created by Brad on 9/11/13.
//  Copyright (c) 2013 Brad. All rights reserved.
//

#import "D1EditPostViewController.h"

@interface D1EditPostViewController ()

@property (nonatomic,strong) NSArray *enteredData;

@end

@implementation D1EditPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self)
    {
        [self receivePostData:self.editPost];
        
    }
}

-(void)receivePostData:(CFPost *)myPost
{
    
    self.userNameTextField.text = myPost.userName;
    self.titleTextField.text = myPost.title;
    self.contentTextField.text = myPost.content;
    self.timeStampTextField.text = myPost.timeStamp;
    
}

- (IBAction)savePressed:(id)sender
{
    CFPost *editedPost = [[CFPost alloc]init];
    
    editedPost.title =self.titleTextField.text;
    editedPost.userName =self.userNameTextField.text;
    editedPost.content =self.contentTextField.text;
    editedPost.timeStamp =self.timeStampTextField.text;
    
    if([self.delegate respondsToSelector:@selector(saveEditedPost:OnCell:)])
    {
        [self.delegate saveEditedPost:editedPost OnCell:self.collectionCellNumber];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)timePressed
{
    D1TimeDataSourceObject *timeDataSource = [[D1TimeDataSourceObject alloc]init];
    
    self.timeStampTextField.text = [NSString stringWithFormat:@" %@", [timeDataSource grabCurrentTime]];
    
    
}
@end
