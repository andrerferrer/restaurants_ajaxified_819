import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["items", "form"]

  connect() {
    console.log(this.element)
    console.log(this.itemsTarget)
    console.log(this.formTarget)
  }

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
  }
}
