import { Controller } from "@hotwired/stimulus"
import { createPicker } from 'picmo';

export default class extends Controller {

  static values = {
    user: Number,
    comment: Number
  }

  displayEmojis(event) {
    console.log(this.userValue)
    console.log(this.commentValue)

    const rootElement = event.currentTarget
    const picker = createPicker({ rootElement })
    picker.addEventListener('emoji:select', event => {
      console.log(event.emoji)
      this.sendReaction(event.emoji)
      picker.destroy()
    })

  }

  sendReaction(emoji) {
    fetch(`/comments/${this.commentValue}/reactions`, {
      method: "POST",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content")
      },
      body: JSON.stringify({
        reaction: {
          reaction_type: emoji
        }
      })
    })
    .then(response => response.json())
    .then(data => {
      console.log(data)
      const reactionList = this.element.querySelector('.reaction-list')
      if (reactionList) {
        reactionList.innerHTML = data.reactions_html
      }
    })
    .catch(error => {
      console.error("There was a problem with the fetch operation:", error);
    });
  }
};
