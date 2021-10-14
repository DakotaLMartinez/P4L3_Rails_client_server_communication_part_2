# Phase 4 - Lecture 3 Client/Server Communication part2

## Today's Topics

- Adding Update/Delete functionality to our API to complete full CRUD
- How to write add column migrations
- Practicing how to break down feature requirements into the RESTful API endpoints they require

## Features for Meetup Clone

- Users can delete an event they created
- Users can leave a group
- Users who rsvp'd to an event can delete their RSVP
- Users can update an event they created
- Users can update whether a user attended an event

## Features for Reading List Application

- Users can update whether or not they have read a book
- Users can remove a book from their reading list

Again, we'll be breaking down the functionality into pieces, starting with the request, going through route, controller, model and leading to a response. Today, I'll be asking for more input from you all about what the RESTful requests should be to support these features.

## Users can delete an event they created

### Request

<details>
  <summary>
    What request method do we need? GET/POST/PATCH or DELETE?
  </summary>
  <hr/>
  DELETE
  <hr/>
</details>
<br />

<details>
  <summary>
    What will the path be?
  </summary>
  <hr/>

  `/events/:id`

  <hr/>

</details>

<br/>
<details>
  <summary>
    Do we need the content-type header? 
  </summary>
  <hr/>

  NO

  <hr/>

</details>


<br/>
<details>
  <summary>
    Do we need a body? If so what will it look like?
  </summary>
  <hr/>

  N/A

  <hr/>

</details>
<br/>

### Route
<br/>
<details>
  <summary>
    What route do we need?
  </summary>
  <hr/>

  ```rb
  resources :events, only: [:destroy]
  ```

  <hr/>

</details>
<br/>

### Controller
<br/>
<details>
  <summary>
    Which controller action(s) do we need?
  </summary>
  <hr/>

  `events#destroy`

  <hr/>

</details>
<br/>

### Model/Database
<br/>
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

  - We need to find the event object we're going to delete using the find method with the id included in the request url parameters.
  - We need to call destroy on that object.

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

  ```rb
  def destroy
    event = Event.find(params[:id])
    event.destroy
  end
  ```
  no content (204 status code) We can get this by leaving off the render.
  
   We can also respond with 200 ok and the deleted record if we want to enable an undo feature from our frontend (we can send a POST request to insert the deleted record again)
  ```rb
  def destroy
    event = Event.find(params[:id])
    event.destroy
    render json: event
  end
  ```
  <hr/>

</details>
<br/>


## Users who rsvp'd to an event can delete their RSVP

### Request
<details>
  <summary>
    What request method do we need? GET/POST/PATCH or DELETE?
  </summary>
  <hr/>
  DELETE
  <hr/>
</details>
<br />

<details>
  <summary>
    What will the path be?
  </summary>
  <hr/>

  `/user_events/:id `

  <hr/>

</details>

<br/>
<details>
<summary>
Do we need the content-type header?
</summary>
<hr/>

NO

<hr/>

</details>


<br/>
<details>
  <summary>
    Do we need a body? If so what will it look like?
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

  `resources :user_events, only: [:destroy]`

  <hr/>

</details>
<br/>

### Controller
<details>
  <summary>
    Which controller action(s) do we need?
  </summary>
  <hr/>

  `user_events#destroy`

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

  - We need to find the `UserEvent` we're going to delete using the find method and the id included in the url parameters of the request. 
  - Then we need to call destroy on that object.

  <hr/>

</details>
<br/>



### Response
<details>
  <summary>
    What should the response be to our API request?
  </summary>
  <hr/>

  ```rb
    def destroy
      user_event = UserEvent.find(params[:id])
      user_event.destroy
    end
  ```

  None needed. If we just leave out the render method, we'll send a 204 no content response by default. We can explicitly send the 204 no content response by adding

  ```rb
  head :no_content
  ```

  <hr/>

</details>
<br/>

## Users can leave a group

### Request

<details>
  <summary>
    What request method do we need? GET/POST/PATCH or DELETE?
  </summary>
  <hr/>
  DELETE
  <hr/>
</details>
<br />

<details>
  <summary>
    What will the path be?
  </summary>
  <hr/>

  `/user_groups/:id`

  <hr/>

</details>

<br/>
<details>
  <summary>
    Do we need the content-type header? 
  </summary>
  <hr/>

  NO

  <hr/>

</details>


<br/>
<details>
  <summary>
    Do we need a body? If so what will it look like?
  </summary>
  <hr/>

  N/A

  <hr/>

</details>
<br/>

### Route
<br/>
<details>
  <summary>
    What route do we need?
  </summary>
  <hr/>

  ```rb
  resources :user_groups, only: [:destroy]
  ```

  <hr/>

</details>
<br/>

### Controller
<br/>
<details>
  <summary>
    Which controller action(s) do we need?
  </summary>
  <hr/>

  `user_groups#destroy`

  <hr/>

</details>
<br/>

### Model/Database
<br/>
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

  - We need to find the `UserGroup` we're going to delete using the find method with the id included in the request url parameters
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

  ```rb
  user_group = UserGroup.find(params[:id])
  user_group.destroy
  ```

  no content (204 status code) We can get this by leaving off the render.
  
  We can also respond with 200 ok and the deleted record if we want to enable an undo feature from our frontend (we can send a POST request to insert the deleted record again)

  <hr/>

</details>
<br/>


## Users can update an event they created

### Request
<details>
  <summary>
    What request method do we need? GET/POST/PATCH or DELETE?
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

  `/events/:id`

  <hr/>

</details>
<br/>


<details>
  <summary>
    Do we need the Content-Type header?
  </summary>
  <hr/>

  YES because we have a JSON body

  <hr/>

</details>
<br/>

<details>
  <summary>
    Do we need a body? If so, what will it include?
  </summary>
  <hr/>

  YES
  - :title
  - :description
  - :location
  - :start_time
  - :end_time
  - :group_id

  To see what these things should be, we can take a look at the corresponding database table in our schema and think about which things a user should be able to edit directly. We can also check the strong parameters in the corresponding controller.

  <hr/>

</details>
<br/>

### Route
<details>
  <summary>
    What route do we need?
  </summary>
  <hr/>

  `patch "/events/:id" => events#update`

  -- or --

  `resources :events, only: [:update]`

  <hr/>

</details>
<br/>

### Controller
<details>
  <summary>
    Which controller action(s) do we need?
  </summary>
  <hr/>

  `events#update`

  <hr/>

</details>
<br/>

### Model/Database

<details>
  <summary>
    Any changes needed to model layer (methods/validations/etc.)?
  </summary>
  <hr/>

  None

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

  - We need to find the event whose id appears in the url parameters of the request
  - We need to try to update that event with the `event_params`

  <hr/>

</details>
<br/>



### Response
<details>
  <summary>
    What should the response be to our API request?
  </summary>
  <hr/>

  - if update succeeds, the json version of the updated event and a 200 status code
  - if not, error messages with 422 status code upon failed validation

   ```rb
  def update
      event = Event.find(params[:id])
      if event.update(event_params)
        render json: event, status: :ok
      else
        render json: event.errors, status: :unprocessable_entity
      end
    end
  ```

  <hr/>

</details>
<br/>




## Users can update whether a user attended an event

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

  `/user_events/:id`

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

- YES
    - event_id
    - attended (boolean)

This could be debatable to an extent.  If we're updating an RSVP, would it make sense to change the event the rsvp belongs to or simply to focus on whether they attended or not? If we decided we only want to allow updating of the attended attribute, what change would we need to make?
  <hr/>

</details>
<br/>

### Route
<details>
  <summary>
    What route do we need?
  </summary>
  <hr/>

  `patch '/user_events/:id', to: 'user_events#update'`

  -- or --

  `resources :user_events, only: [:update]`

  <hr/>

</details>
<br/>

### Controller
<details>
  <summary>
    Which controller action(s) do we need?
  </summary>
  <hr/>

  `user_events#update`

  <hr/>

</details>
<br/>

<details>
  <summary>
    Can we use our strong parameters from create or is update different for some reason?
  </summary>
  <hr/>

  In this case, we probably don't want to allow `event_id` through when doing an update, so we'll need a separate method for `update_user_event_params` here to only permit `attended` to be updated.

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

  YES! We don't currently have an attended column in the user_events table, so we'll need to add that.

  <hr/>

</details>
<br/>



<details>
  <summary>
    What model objects are involved and how do we interact with them in the controller?
  </summary>
  <hr/>

  - We need to find the `UserEvent` object to update by using the find method with the id including in the url parameters of the request.
  - We need to call update on that object and pass only the attended parameter (using strong_params)

  ```rb
  def update_user_event_params
    params.permit(:attended)
  end
  ```

  <hr/>

</details>
<br/>


### Response
<details>
  <summary>
    What should the response be to our API request?
  </summary>
  <hr/>

  - if update succeeds, the json version of the updated user_event and a 200 status code
  - if not, error messages with 422 status code upon failed validation

  ```rb
  def update
    user_event = UserEvent.find(params[:id])
    if user_event.update(update_user_event_params)
      render json: user_event, status: :ok
    else
      render json: user_event.errors, status: :unprocessable_entity
    end
  end
  ```

  <hr/>

</details>
<br/>




## Bonus Notes from the End of Time

```rb
# GET '/books/:id' # I don't get everything, but I see maybe the 10 most recent comments
# GET '/books/:book_id/comments' => all comments on book
# POST '/books/:book_id/user_books'
# GET '/books' allows you to make a request that has url parameters like this:
# http://localhost:3000/books?author=Malcolm+Gladwell'

# resources :posts do 
#   resources :comments
# end

# resources :users do 
#   resources :user_books, only: [:index]
# end

#get '/users/:user_id/user_books', to: "user_books#index"
```

Chaining scopes

```rb
class Post
  def self.search(options)
    results = self.all
    allowed_options = ["author", "publication_year"]
    allowed_options.each do |option|
      if options['option']
        results = results.where(option: options['option'])
      end
    end
    results
  end
end
```
