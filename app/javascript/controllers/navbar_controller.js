import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  updateNavbar() {
    if (window.scrollY >= (window.innerHeight/4) ) {
      this.element.classList.add("navbar-cyclon-white")
    } else {
      this.element.classList.remove("navbar-cyclon-white")
    }
  };
}
