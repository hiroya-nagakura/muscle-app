// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
//actiontext
require("trix")
require("@rails/actiontext")
//Bootstrap
require('bootstrap/dist/js/bootstrap.min.js')
//Jquery
require('jquery')
//ネストフォーム
require("@nathanvda/cocoon")
//グラフ
require("chartkick")
require("chart.js")

require('javascripts/static_pages/slide')
require('javascripts/static_pages/scroll-button')
require('javascripts/bodyweights/chart-change')
require('javascripts/bodyweights/modal')
require('javascripts/users/preview')
require('javascripts/layouts/flash-message')
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


import '../stylesheets/application';
import '../stylesheets/actiontext';