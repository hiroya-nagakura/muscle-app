document.addEventListener('turbolinks:load', function() {
	const target_favorite = document.getElementById('favorite-menu-card');
	if (target_favorite){
		// 移動幅を取得 //
		const scrollvalue_favorite = target_favorite.clientWidth;
	// クリックしたら右、もしくは左へ移動幅分動く
	$('#favorite-scroll-left').on('click', function() {
		$(target_favorite).animate({scrollLeft: target_favorite.scrollLeft - scrollvalue_favorite}, 500, "swing");
	});

	$('#favorite-scroll-right').on('click', function() {
		$(target_favorite).animate({scrollLeft: target_favorite.scrollLeft + scrollvalue_favorite}, 500, "swing");
	});
	}

	const target_new = document.getElementById('new-menu-card');
	if (target_new){
		// 移動幅を取得 //
		const scrollvalue_new = target_new.clientWidth;
	// クリックしたら右、もしくは左へ移動幅分動く
	$('#new-scroll-left').on('click', function() {
		$(target_new).animate({scrollLeft: target_new.scrollLeft - scrollvalue_new}, 500, "swing");
	});

	$('#new-scroll-right').on('click', function() {
		$(target_new).animate({scrollLeft: target_new.scrollLeft + scrollvalue_new}, 500, "swing");
	});
	}
});