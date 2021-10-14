# Phase 4, Lecture 3 - Client Server Communication part 2 Exercise

Today's focus:

- building out `update` and `delete` actions in our controllers

# Reading List Application


- Users can update whether or not they have read a book
- Users can remove a book from their reading list
## Users can update whether or not they have read a book

We need to be able to send a request from our client application to update whether or not the currently logged in user has read a given book.

### Request
<details>
  <summary>
    What request method do we need?
  </summary>
  <hr/>

  `PATCH`

  <hr/>

</details>
<br/>

<details>
  <summary>
    What will the path be?
  </summary>
  <hr/>

  `/user_books/:id`

  <hr/>

</details>
<br/>


<details>
  <summary>
    Do we need the Content-Type header?
  </summary>
  <hr/>

  YES

  <hr/>

</details>
<br/>

<details>
  <summary>
    Do we need a body? If so, what will it include?
  </summary>
  <hr/>

  YES
  - read

  <hr/>

</details>
<br/>

### Route
<details>
  <summary>
    What route do we need?
  </summary>
  <hr/>

  `patch "/user_books/:id" => user_books#update`

  -- or --

  `resources :user_books, only: [:update]`

  <hr/>

</details>
<br/>

### Controller
<details>
  <summary>
    Which controller action(s) do we need?
  </summary>
  <hr/>

  `user_books#update`

  <hr/>

</details>
<br/>

<details>
  <summary>
    Can we use our strong parameters from create or is update different for some reason? (only relevant for update actions)
  </summary>
  <hr/>

  In this case, we probably don't want to allow `book_id` through when doing an update, so we'll need a separate method for `user_book_params` here to only permit `read` to be updated.

  <hr/>

</details>
<br/>

### Model/Database
<details>
  <summary>
    Any changes needed to model layer (methods/validations/etc.)?
  </summary>
  <hr/>

  Nope!

  <hr/>

</details>
<br/>

<details>
  <summary>
    Any changes needed to the database to support this request?
  </summary>
  <hr/>

  Nope!

  <hr/>

</details>
<br/>

<details>
  <summary>
    What model objects are involved and how do we interact with them in the controller?
  </summary>
  <hr/>

  - We need to find the `UserBook` object to update using the find method and the `id` included in the url parameters of the request.
  - We need to update the object using the `update_user_book_params`

  <hr/>

</details>
<br/>


### Response
What should the response be to our API request?
- ...
<details>
  <summary>
    What should the response be to our API request?
  </summary>
  <hr/>

  - if update succeeds, the json version of the updated user_book and a 200 status code
  - if not, error messages with 422 status code upon failed validation

  <hr/>

</details>
<br/>


## Users can remove a book from their reading list

We need to be able to send a request from our client application to the API to allow the current user to remove a book from their reading list.

### Request

<details>
  <summary>
    What request method do we need?
  </summary>
  <hr/>

  `DELETE`

  <hr/>

</details>
<br/>

<details>
  <summary>
    What will the path be?
  </summary>
  <hr/>

  `/user_books/:id`

  <hr/>

</details>
<br/>

<details>
  <summary>
    Do we need the Content-Type header?
  </summary>
  <hr/>

  NO

  <hr/>

</details>
<br/>

<details>
  <summary>
    Do we need a body? If so, what will it include?
  </summary>
  <hr/>

  N/A

  <hr/>

</details>
<br/>

### Route
<details>
  <summary>
    What route do we need?
  </summary>
  <hr/>

  `delete "/user_books/:id" => user_books#destroy`

  -- or --

  `resources :user_books, only: [:destroy]`

  <hr/>

</details>
<br/>


### Controller
<details>
  <summary>
    Which controller action(s) do we need?
  </summary>
  <hr/>

  `user_books#destroy`

  <hr/>

</details>
<br/>


### Model/Database
<details>
  <summary>
    Any changes needed to model layer (methods/validations/etc.)?
  </summary>
  <hr/>

  Nope!

  <hr/>

</details>
<br/>

<details>
  <summary>
    Any changes needed to the database to support this request?
  </summary>
  <hr/>

  Nope!

  <hr/>

</details>
<br/>

<details>
  <summary>
    What model objects are involved and how do we interact with them in the controller?
  </summary>
  <hr/>

  - We need to find the `UserBook` we're going to delete using the find method with the id included in the request url parameters
  - and then we need to call destroy on that object.

  <hr/>

</details>
<br/>

### Response
<br/>
<details>
  <summary>
    What should the response be to our API request?
  </summary>
  <hr/>

  no content (204 status code) We can get this by leaving off the render.
  
  We can also respond with 200 ok and the deleted record if we want to enable an undo feature from our frontend (we can send a POST request to insert the deleted record again)

  <hr/>

</details>
<br/>