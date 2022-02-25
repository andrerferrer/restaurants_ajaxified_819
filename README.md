## Rails AJAXified

### Remote true

Just by adding `remote: true`, it works right out of the box.

### With Stimulus and Fetch

But what if I want to change only one small section?

Then, follow this flow:
1- add a stimulus controller in the HTML
```erb
<div id="stimulus-controller" data-controller="insert-in-list"> <!-- this data controller -->
  <h4>Add a Review</h4>
  <%= simple_form_for([@restaurant, @review], 
                      data: { 
                        insert_in_list_target: "form", 
                        action: "submit->insert-in-list#send"
                      }) do |f| %> <!-- these data properties above -->
    <%= f.input :comment %>
    <%= f.input :rating %>
    <%= f.submit class: "btn btn-primary" %>
  <% end %>
  <ul data-insert-in-list-target='items'> <!-- this data property -->
    <% @restaurant.reviews.each do |review| %>
      <li id="review-<%= review.id %>">
        <%= review.comment %> - <%= "⭐" * review.rating %>
      </li>
    <% end %>
  </ul>
</div>
```

2- create that stimulus controller JS
`app/javascript/controllers/insert_in_list_controller.js`
```js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items", "form"]

  connect() {
  }
}
```
3- make the controller handle the JSON request
`app/javascript/controllers/insert_in_list_controller.js`
```js
  send(event) {
    // we prevent the default behavior of the form (reload the page)
    event.preventDefault();
    // we find the form element
    const form = this.formTarget;
    // take the info from the form
    const info = new FormData(form)
    // make an ajax request to the server
    const url = form.action;
    fetch(form.action, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: info
    })
    .then(response => response.json())
    .then((data) => {
      // DO SOMETHING LATER
    })
  }
```
4- make a json response
`app/views/reviews/create.json.jbuilder`

```ruby
  if @review.persisted?
    json.form json.partial!("restaurants/form.html.erb", restaurant: @restaurant, review: Review.new)
    json.inserted_item json.partial!("restaurants/review.html.erb", review: @review)
  else
    json.form json.partial!("restaurants/form.html.erb", restaurant: @restaurant, review: @review)
  end
```
5- handle the json response
`app/javascript/controllers/insert_in_list_controller.js`
```js
    .then((data) => {
      // the response is the JSON created in
      // app/views/reviews/create.json.jbuilder
      
      // if we have the key inserted_item
      if (data.inserted_item) {
        // we insert that inserted_item (the <li> with the review), in the DOM
        this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
      }
      // either way, we insert that form (from the json) in the DOM
      this.formTarget.outerHTML = data.form
    })
```
