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

var jQuery = require('jquery')
require("jquery-ui-dist/jquery-ui")
require("jquery-ui")

global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

//bootstrap
require("bootstrap")
require("@fortawesome/fontawesome-free/scss/fontawesome.scss")
require("@fortawesome/fontawesome-free/js/all.js")
require("owl.carousel/dist/owl.carousel.min")


import './home'
import './alert'
import './join_group'
import './media'
import './sidebar'


