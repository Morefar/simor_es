$(document).ready(function(){
  $('.down-scroll').on('click', function() {
    var nextWaypoint = $(this).parent('.hero-panel').waypoint('next');
    console.log('the next waypoint is', nextWaypoint[0]);
    if (nextWaypoint[0] === undefined)
      nextWaypoint[0] = '#track';
    console.log('the next waypoint is', nextWaypoint[0]);
    $.smoothScroll({
      scrollTarget: nextWaypoint[0],
      speed: 2500
    });
    return false;
  });

  $('.back-to-top').on('click', function() {
    $.smoothScroll({ scrollTarget: '#page_header', speed: 500, offset: 0 });
  });

  $('.hero-panel').waypoint(function(direction) {
  }, {
  });
});
