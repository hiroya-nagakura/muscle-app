$(document).on('turbolinks:load', function() {
  var daily_btn = document.getElementById("daily-chart-btn");
  var weekly_btn = document.getElementById("weekly-chart-btn");
  var monthly_btn = document.getElementById("monthly-chart-btn");
  var daily_chart = document.getElementById("daily-chart");
  var weekly_chart = document.getElementById("weekly-chart");
  var monthly_chart = document.getElementById("monthly-chart");

  var remove_active = function() {
    daily_btn.classList.remove("active");
    weekly_btn.classList.remove("active");
    monthly_btn.classList.remove("active");
    daily_chart.classList.remove("active");
    weekly_chart.classList.remove("active");
    monthly_chart.classList.remove("active");
  };

  $(daily_btn).on('click', function() {
    remove_active();
    $(daily_btn).addClass('active');
		$(daily_chart).addClass('active');
  });
  
  $(weekly_btn).on('click', function() {
    remove_active();
    $(weekly_btn).addClass('active');
		$(weekly_chart).addClass('active');
  });
  
  $(monthly_btn).on('click', function() {
    remove_active();
    $(monthly_btn).addClass('active');
		$(monthly_chart).addClass('active');
	});
});