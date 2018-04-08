# users

```swift
let users = zulip.users()
```

## Functions

### users.getAll

Gets all user profiles in the current realm.

#### Parameters

 - `clientGravatar`: Whether Gravatars should not be sent if the user
   does not have an avatar. (`true` means that `avatar_url` will be
   `nil` if the user does not have an avatar; `false` means that an
   `avatar_url` will be a Gravatar).
 - `callback`: A callback, which will be passed a list of users, or an
   error if there is one.

### users.getCurrent

Gets the current user's profile.

#### Parameters

 - `callback`: A callback, which will be passed the profile, or an
   error if there is one.

### users.create

Creates a new user. `create` will send a `ZulipError` if the user is not an
admin.

#### Parameters

 - `email`: The new user's email address.
 - `password`: The new user's password.
 - `fullName`: The new user's full name.
 - `shortName`: The new user's short name.
 - `callback`: A callback, which will be passed an error if there is
   one.
