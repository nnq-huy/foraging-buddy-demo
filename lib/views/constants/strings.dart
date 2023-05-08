import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const appName = 'Foraging Buddy';
  static const guides = 'Guides';
  static const pickingSpots = 'Picking spots';
  static const identifier = 'Identifier';

  static const welcomeToAppName = 'Welcome to ${Strings.appName}';
  static const youHaveNoPosts =
      'You have not made a post yet. Press either the video-upload or the photo-upload buttons to the top of the screen in order to upload your first post!';
  static const noPostsAvailable =
      "Nobody seems to have made any posts yet. Why don't you take the first step and upload your first post?!";
  static const enterYourSearchTerm =
      'Enter your search term in order go get started. You can search in the description of all posts available in the system';
  static const facebook = 'Facebook';
  static const facebookSignupUrl = 'https://www.facebook.com/signup';
  static const google = 'Google';
  static const googleSignupUrl = 'https://accounts.google.com/signup';
  static const logIntoYourAccount =
      'Log into your account using one of the options below.';
  static const comments = 'Comments';
  static const postDetails = 'Post Details';
  static const post = 'post';

  static const createNewPost = 'Create New Post';
  static const pleaseWriteYourMessageHere = 'Please write your message here';
  static const writePostTitle = 'Please write your post title here';
  static const writeResultTitle = 'Please write a name for this result';

  static const noCommentsYet =
      'Nobody has commented on this post yet. You can change that though, and be the first person who comments!';

  static const enterYourSearchTermHere = 'Enter your search term here';
  static const searchPosts = 'Search for posts';
  static const searchResults = 'Search for identifier results';
  static const searchMushrooms = 'Search for mushrooms';

  // login view rich text at bottom
  static const dontHaveAnAccount = "Don't have an account?\n";
  static const signUpOn = 'Sign up on ';
  static const orCreateAnAccountOn = ' or create an account on ';

  static const comment = 'comment';

  static const loading = 'Loading...';

  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';

  static const delete = 'Delete';
  static const areYouSureYouWantToDeleteThis =
      'Are you sure you want to delete this';

  // log out
  static const logOut = 'Log out';
  static const areYouSureThatYouWantToLogOutOfTheApp =
      'Are you sure that you want to log out of the app?';
  static const cancel = 'Cancel';
//user post
  static const postCreated = 'Post created';
  static const postDeleted = 'Post deleted';
  static const showOnMap = 'Show on map';
  // mushroom identifier
  static const result = 'result';
  static const resultDetails = 'Result details';

  static const pleasePickPhoto = 'Please pick a photo';
  static const uploadResult = 'Upload result';
  static const takePhoto = 'Take a photo';
  static const pickPhoto = 'Pick from gallery';
  static const failToRecognize = 'Fail to recognize';
  static const analyzing = 'Analyzing...';
  static const accuracy = 'Accuracy';
  static const saveResult = ' Save identification result';
  static const pleaseWriteResultTitle = 'Please write a title';
  static const resultSaved = 'Result saved!';
  static const resultDeleted = 'Result deleted';
  static const mapView = 'Mapview';
  static const listView = 'Listview';
  static const gridView = 'Gridview';
  static const identify = 'Identify';

  //user profile
  static const userProfile = 'User Profile';
  static const accountType = 'Account Type';
  static const name = 'Name';
  static const email = 'Email';
  static const upgradePro = 'Upgrade to pro';
// mushroom guides
  static const warning = '';
  const Strings._();
}
