//
//  D1ViewController.m
//  CFPosts
//
//  Created by Brad on 9/10/13.
//  Copyright (c) 2013 Brad. All rights reserved.
//

#import "D1ViewController.h"
#import "D1collectionviewcell.h"



@interface D1ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong,nonatomic) D1PostCollection *postCollection;
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong,nonatomic) CFPost *editData;
@property (nonatomic) NSInteger selectedCell;






@end

@implementation D1ViewController

-(void)savePost:(NSArray *)data
{
    

    NSLog(@"delegation is working");
    
    CFPost *newPost = [[CFPost alloc]init];
    newPost.userName = data[0];
    newPost.title = data[1];
    newPost.content = data[2];
    newPost.timeStamp = data[3];
    newPost.backgroundColor = [UIColor randomColor];
    
    
    [self.postCollection.myPosts addObject:newPost];
    
    

    
    [self.myCollectionView reloadData];
    
}

-(void)saveEditedPost:(CFPost *)data OnCell:(NSInteger)cell
{
    self.postCollection.myPosts[cell] = data;
    [self.myCollectionView reloadData];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	self.postCollection = [[D1PostCollection alloc]init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if ([segue.identifier isEqualToString:@"newBlogPost"])
    {
        D1NewViewController *newVC = segue.destinationViewController;
        newVC.delegate = self;
        
        
    }
    if ([segue.identifier isEqualToString:@"editBlogPost"])
    {
        D1EditPostViewController *editVC = segue.destinationViewController;
        editVC.delegate = self;
        CFPost *postEdit = self.editData;
        
        editVC.editPost = postEdit;
        editVC.collectionCellNumber = self.selectedCell;
        
        
        
        
        
    }
}

//START OF UICOLLECTIONVIEW DATASOURCE METHODS


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.postCollection.myPosts count];
    
  
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCell" forIndexPath:indexPath];
        
        CFPost *post = [self.postCollection.myPosts objectAtIndex:indexPath.item];
        
        [self updateCell:cell usingPost:post];

           return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.editData = self.postCollection.myPosts[indexPath.item];
    self.selectedCell = indexPath.item;
    [self performSegueWithIdentifier:@"editBlogPost" sender:self    ];

}


//END OF UICOLLECTIONVIEW DATASOURCE METHODS

-(void)updateCell:(UICollectionViewCell *)cell usingPost:(CFPost *)post
{
    D1PostView *postView = ((D1collectionviewcell *)cell).postView;
    
    

            CFPost *myPost = (CFPost *)post;
            postView.userName.text = myPost.userName;
            postView.title.text = myPost.title;
            postView.content.text = myPost.content;
            postView.timeStamp.text = myPost.timeStamp;
    cell.backgroundColor = myPost.backgroundColor;
        }

- (IBAction)mySaveUnwindSegueCallback:(UIStoryboardSegue *)segue
{
    
}


@end
