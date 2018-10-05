$('.review-rating').raty({
  readOnly: true,
  path: '/assets/',
  score: function() {
    return $(this).attr('data-score');
  }
});
