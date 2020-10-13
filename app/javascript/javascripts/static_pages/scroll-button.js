$(document).on('turbolinks:load', function() {
	var target_favorite = document.getElementById('favorite-menu-card');
	if (target_favorite){
		var scrollvalue_favorite = target_favorite.clientWidth;
	}
	$('#favorite-scroll-left').on('click', function() {
		$(target_favorite).animate({scrollLeft: target_favorite.scrollLeft - scrollvalue_favorite}, 500, "swing");
	});

	$('#favorite-scroll-right').on('click', function() {
		$(target_favorite).animate({scrollLeft: target_favorite.scrollLeft + scrollvalue_favorite}, 500, "swing");
	});

	var target_new = document.getElementById('new-menu-card');
	if (target_new){
		var scrollvalue_new = target_new.clientWidth;
	}
	$('#new-scroll-left').on('click', function() {
		$(target_new).animate({scrollLeft: target_new.scrollLeft - scrollvalue_new}, 500, "swing");
	});

	$('#new-scroll-right').on('click', function() {
		$(target_new).animate({scrollLeft: target_new.scrollLeft + scrollvalue_new}, 500, "swing");
	});
});