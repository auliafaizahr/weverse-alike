$(document).on('turbolinks:load', function(){
  $('.owl-carousel').owlCarousel({
    loop:false,
    margin:15,
    nav:true,
    navText: [
        '<i class="fa fa-angle-left" aria-hidden="true"></i>',
        '<i class="fa fa-angle-right" aria-hidden="true"></i>'
    ],
    responsive:{
        0:{
            items:1
        },
        600:{
            items:3
        },
        1000:{
            items:4
        }
    }
})
});
