// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

//= require jquery
//= require jquery_ujs
//= require semantic-ui

const messages = document.querySelector('#messages')
//Scroll to the bottom of the html component when loading the page
const scroll_bottom = function() {
    messages.scrollTo(0, messages.scrollHeight)
}

window.onload = scroll_bottom()

//Enable to submit the message with the return key and clear the input field after that
const submit_message = () => {
    document.querySelector('#message_body').addEventListener('keypress', function(e) {
        if (e.keyCode == 13) {
            document.querySelector('button').click();
            e.target.value = "";
        }
    })

}

submit_message()
