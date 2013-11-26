	window.Customise = {

		initialize: function(data) {
			Customise.themeEvents();
			editor = data.editor;
		},
		slideTiming: 300,

		themeEvents: function() {
			//
			// Sliding events
			// --------------------------------------------------	
			$("#slider").on("scroll", function(event) {
				Customise.moveSlidePosition(event);
			});

			$("#cancel_theme_button").on("click", function(event) {
				Customise.slideClickHandler($(this), 300);
			});
			$("#back_to_themes_button").on("click", function(event) {
				Customise.slideClickHandler($(this), 0);
			});
			$("#edit_html_button").on("click", function(event) {
				Customise.slideClickHandler($(this), 600);
				setTimeout( function(){
			        $('#preview_container').css('left','600px');
					$('#drawer').css('width','600px');
					$('#slider').css('width','600px');
			    },300);
				
				
			});
			$("#back_to_appearance_button").on("click", function(event) {
				Customise.slideClickHandler($(this), 300);
				setTimeout( function(){
			        $('#preview_container').css('left','300px');
					$('#drawer').css('width','300px');
					$('#slider').css('width','300px');
			    },200);	
			});

			$("#update_preview_button").on("click", function() {
				var id = $('#current_store_id').val();
				var username = $('#current_username').val();
				var str = editor.getSession().getValue();
				
			    $.ajax({
		          type: "POST",
		          url: '/stores/update_theme_content',
		          dataType: "json",
		          data: {custom_html: str, id: id, username: username },
		          complete: function(result){
		          	if(result) {
		          		alert("yay!");

		          	}else {
		          		alert("nay!");

		          	}
		              
		          }
			    });

			});

		},

		moveSlidePosition: function(event) {
			$(".slide").css({ 
				"background-position": $(event.target).scrollLeft()/6-100+ "px 0"
			});

		},

		slideClickHandler: function(el, by) {
			var slider = $("#slider");
			slider.animate({
				scrollLeft: by
			}, this.slideTiming);
		}



	};