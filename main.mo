// main.mo

import List "mo:stdlib/List";
import Text "mo:stdlib/Text";

// Define a simple data structure for a learning platform
type User = { id: Text; name: Text; courses: List<Text> };

// Define the main decentralized learning canister
actor class DecentralizedLearning() {
  var users : [User] = [];
  
  // Register a new user
  public shared({ id, name }: { id: Text; name: Text }) : async () -> User {
    let newUser = { id, name, courses = [] };
    users := users ++ [newUser];
    newUser;
  };

  // Enroll a user in a course
  public shared({ userId, courseId }: { userId: Text; courseId: Text }) : async () -> User {
    var updatedUsers = [];
    for (user in users) {
      if (user.id == userId) {
        updatedUsers := updatedUsers ++ [{ user with courses = user.courses ++ [courseId] }];
      } else {
        updatedUsers := updatedUsers ++ [user];
      };
    };
    users := updatedUsers;
    updatedUsers[0];
  };

  // Get information about a user
  public query shared({ userId }: { userId: Text }) : async -> ?User {
    List.find(users, func(user) { user.id == userId });
  };
};
