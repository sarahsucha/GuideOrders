$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $('.nav li').on('click', function() {
    $('.nav li').removeClass('active');
    $(this).addClass('active');
  })

  var path = window.location.pathname;
  console.log(path)

  // if(path == '') {
  //   path = '/';
  // }

  $('.nav [href="' + path + '"]').on('load', function() {
    $(this).addClass('active');
  })

  // $('.nav [href="' + path + '"]').addClass('active');
  // target.addClass('active');
  // console.log($(".nav a[href='" + path + "']"))
  // console.log(target)
  //
  // $('.nav a').filter(function() {
  //   return this.href == path;
  // }).addClass('active');

});
