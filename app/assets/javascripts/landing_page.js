jQuery(function($){
  $('a').click(function() {
   $.get('/challenges/new', function(data) {
     $('div#content').html(data);
   });
  });
});
