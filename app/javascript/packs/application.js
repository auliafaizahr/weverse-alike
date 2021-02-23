// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'core-js/stable'
import 'regenerator-runtime/runtime'
import '../stylesheets/application.scss'

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

//bootstrap
require("bootstrap")
require("@fortawesome/fontawesome-free/scss/fontawesome.scss")
require("@fortawesome/fontawesome-free/js/all.js")

window.jQuery = $;
window.$ = $;

import './home'
import './alert'



