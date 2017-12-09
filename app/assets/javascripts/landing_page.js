jQuery(function($){
  $('a').click(function() {
   $.get('/questions/new', function(data) {
     $('div#content').html(data);
   });
  });
});
