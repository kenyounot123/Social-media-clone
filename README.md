# Stellar (Social media clone)
Created a full-stack social media site consisting of the core user functionalities of any social media apps such as Facebook, Twitter, threads, etc.
Users must sign in to access the site and can even sign in through Github. Once signed in, a confirmation email will be sent to the user. Users can create posts (using texts and images), like posts, comment on posts, as well as follow and unfollow other users. 
Screenshots of website shown below.
**Link to project:** none.com/
![alt tag](http://placecorgi.com/1200/650)
## How It's Made:

**Tech used:** HTML, CSS, JavaScript, Bootstrap, Ruby on Rails, Ruby, Hotwire

I used Devise and OAuth for user authentication. The only OAuth provider I used was GitHub. Devise was very useful for authentication and when testing user sign in using RSpec.

It was my first time using Boostrap in any rails application so I tried my best to make everything responsive. I used it just to create a basic front-end layout to make everything look nice but for this application I mainly focused on the back-end.

I first started working on the Post functionality. So users can create posts, comment on them, view them, and like them. I wanted to make this function as a single page application so I did this using Hotwire through the use of Turbo. With Turbo, I created a lot of turbo frames dividing the page into components and through the use of turbo streams I was able to append and remove posts, comments, and replies all in a single page. I also used stimulus for clearing form fields after submitting. At first it was challenging to try to do this but I realized that each turbo frame had to have an unique ID for this to work.

Functions like `Likes`, `Replies`, `Comments`, and `Follows` involved complex associations and polymorphic associations. For instance, to implement users being able to like many posts and follow other users, I needed to create two separate models with `has_one_through_many` associations with the user. For following and follower relationships being able to be one sided, I created active relationships and passive relationships to capture each scenario. I made sure these models worked properly and had the right associations by writing model tests using RSpec.

I used Rails' Action Mailer for sending out welcome emails after a user has newly created their account and signed in. I also used Action Storage to store images in a local disk for `Posts` image uploading and `User` avatars.
## Screenshots
![image](https://github.com/kenyounot123/Social-media-clone/assets/70028795/42b331ac-c7b8-4f67-9099-241a1cb35c54)
![image](https://github.com/kenyounot123/Social-media-clone/assets/70028795/c6f295de-2284-4d98-835a-1355e9b95fcf)
![image](https://github.com/kenyounot123/Social-media-clone/assets/70028795/0e7fbe08-63ae-4f98-a9b8-fb4452a9e672)
![image](https://github.com/kenyounot123/Social-media-clone/assets/70028795/81e5c1cc-550d-41ff-9188-f4649f279a71)
## Future edits:
Make dark mode feature
Make search feature

## Lessons Learned:
