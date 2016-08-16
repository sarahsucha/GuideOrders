$(document).ready(function() {

  // $('.nav li').on('click', function() {
  //   $('.nav li').removeClass('active');
  //   $(this).addClass('active');
  // })

  var path = window.location.pathname;
  console.log(path)

  // if(path == '') {
  //   path = '/';
  // }

  $('.nav [href="' + path + '"]').parent().addClass('active');

  // $('.nav [href="' + path + '"]').addClass('active');
  // target.addClass('active');
  // console.log($(".nav a[href='" + path + "']"))
  // console.log(target)
  //
  // $('.nav a').filter(function() {
  //   return this.href == path;
  // }).addClass('active');

  deleteListener();

});

var deleteListener = function() {
  $('.delete-btn').on('click', function(event) {
    event.preventDefault();
    var address = $(this).attr('href');
    console.log(address);
    var that = this;
    if (confirm("Are you sure you want to delete this order?")) {
      var request = $.ajax({
        url: address,
        type: 'delete'
      });

      request.done(function(response) {
        console.log("Request successful");
        $(that).parents('.panel-default').remove();
      });

      request.fail(function(response) {
        console.log("Request failed");
      });
    }
  })
}
