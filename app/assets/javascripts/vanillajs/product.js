	window.NewProduct = {
		el: {
			slider: $("#form-slider"),
			allSlides: $(".slide")

		},
		initialize: function() {
			this.ProductNewEvents();
			//this.ProductEditEvents();
		},
		slideTiming: 800,
		slideWidth: 790,
		ProductNewEvents: function() {

			$('#slide-1').data('offset-top', $('#slide-1').offset().top); //store the initial offset top 

			//
			// Sliding events
			// --------------------------------------------------	
			$("#form-slider").on("scroll", function(event) {
				NewProduct.moveSlidePosition(event);

				$('#slide-1, #slide-2').offset({ // keep slides 1 and 2 in their original positions
				        top: $('#slide-1').data('offset-top')
				});
			});

			$(".steps").on("click", "a", function(event) {
				//var current_step = $('')
				NewProduct.navClickHandler(event, $(this));
				$('#slide-1, #slide-2').offset({ // keep slides 1 and 2 in their original positions
				        top: $('#slide-1').data('offset-top')
				});
			});
			//
			// File manip
			// --------------------------------------------------			
			//Transfering the file ids to the new product form
			$('#new_product').on('click',function() {
				$(this).find('.inputError').removeClass("inputError");
				$('.product-files-id').appendTo('.productFilesIds');
			});

			//
			// Quantity
			// --------------------------------------------------	
			$("#product_unlimited").click(function(){
		        if ($("#product_unlimited").is(':checked')){
		            $("#product_quantity").val('');
		            $("#product_quantity").attr('disabled',true);
		        }else{
		            $("#product_quantity").attr('disabled',false);
		        }
		    });

			//
			// Pricing
			// --------------------------------------------------			
			//pricing radio buttons
			$('.pricing input[type=radio]').click(function() {
				var checked = $('.pricing input[type=radio]:checked').val();
			   	NewProduct.PricingHandler(checked);
			});	

			//
			// Shipping
			// --------------------------------------------------

			//Adding more shipping options
			$('.add_soptions').on('click',function(event) {
				time = new Date().getTime();
				regexp = new RegExp($(this).data('id'), 'g');
				$(this).before($(this).data('sprofiles').replace(regexp, time));
				$('.shipping-profile-form').removeClass('none');
				$('.shipping-profile-subheader').removeClass('none');
				$('.shipping_profile > h4 > li').appendTo('.shipping-profile-form ul');
				event.preventDefault();
			});
			//Removing shipping options
			$(document).on('click','.remove_soptions', function(event){
				NewProduct.customFieldRemove($(this), 'li');
                                event.preventDefault();
			});

			//
			// Custom form fields
			// --------------------------------------------------	
			$('.add_fields').on('click', function(event){
				time = new Date().getTime();
				regexp = new RegExp($(this).data('id'), 'g');
				$(this).before($(this).data('fields').replace(regexp, time));
				custom = $('.custom-form').find('li.current').html();
				//Use APPENDTO
				$('#custom-fields').append('<li class="custom-field-option">' + custom + '</li>');
				if ($(".current")[0]){
		           $(".custom-form").find('li.current').remove();
		        }
				event.preventDefault();

			});	


			$(document).on('click','.remove_fields', function(event){
				NewProduct.customFieldRemove($(this), 'li.custom-field-option');
                                event.preventDefault();
			});	

			//
			// Offers
			// --------------------------------------------------			
			$('.add_offers').on('click', function(event){
				time = new Date().getTime();
				regexp = new RegExp($(this).data('id'), 'g');
				$(this).before($(this).data('offers').replace(regexp, time));
				$('.offer-form').removeClass('none');
				$('.offers > h4 > li').appendTo('ul#offers');
				event.preventDefault();
			});

			$(document).on('click','.remove_offers', function(event){
				NewProduct.customFieldRemove($(this), 'li');
                                event.preventDefault();
			});

			//
			// Tags
			// --------------------------------------------------
			$('.add_tags').on('click', function(event){
				$('.tag-form').removeClass('none');
				event.preventDefault();
			});

			//
			// Referrals
			// --------------------------------------------------
			$('.add_referral').on('click', function(event){
				$('.referral-form').removeClass('none');
				event.preventDefault();
			});

		},

		ProductEditEvents: function() {
			if ($("#product_pricing_fixed_price").is(':checked')){
		        $(".fp-fields").show();
		    }
		    if ($("#product_pricing_pay_anything_from").is(':checked')){
		       $(".panyf").show();
		    }
		    if ($("#product_pricing_auction").is(':checked')){
		        $(".auction_data").show();
		    }

		},

		moveSlidePosition: function(event) {
			$(".slide").css({ 
				"background-position": $(event.target).scrollLeft()/6-100+ "px 0"
			});

		},

		navClickHandler: function(event, el) {
			event.preventDefault();
			var formSlider = $(NewProduct.el.slider.selector);
			var position = $(el).attr("href").split("-").pop();
			var currentForm = formSlider.attr("data-position");
			if(NewProduct.formValidation(currentForm)){
				formSlider.attr("data-position",position);
				formSlider.animate({
					scrollLeft: position * this.slideWidth
				}, this.slideTiming);
				this.changeActiveNav(el);
			}
		},
		changeActiveNav: function(el) {
			$('.steps > .grid_9 > ol > li').removeClass("active");
			$(el).closest('li').removeClass("disabled").addClass("active");
		},
		formValidation: function(currentForm) {
			if(currentForm != 0){
				//$("#new_file_handler").hide();
				return true;
			}else {
				//$("#new_file_handler").show();
				var error = 0;
				var fields  	= $("#product_product_title, #product_description");
				var coverEl 	= $("#cover_file");
				var coverDiv 	= $("#cover_uploader");
				var catSelect 	= $("#product_category_id");
				var quantity 	= $('#product_quantity');
				var unlcheck 	= $('#product_unlimited');

				$('#new_product').find('.inputError').removeClass("inputError");

				fields.each(function() {
					var dis = $(this);
					var value = dis.val();
					if(value.length < 3){
						dis.addClass('inputError');
						error++;
					}else {
						dis.removeClass('inputError');
					}
				});
				//if(coverEl.find('img').length == 0) {
				//	coverDiv.addClass('inputError');
				//	error++;
				//}
				if(catSelect[0].selectedIndex <= 0) {
					catSelect.addClass('inputError');
					error++;
				}
				if(quantity.val() == "" && !unlcheck.is(':checked')) {
					quantity.addClass('inputError');
					error++;
				}
				if(error == 0){
					return true;
				}else {
					return true;
				}
			}
			


		},
		customFieldRemove: function(el, target) {

				$(el).prev('input[type=hidden]').val('1');
				$(el).closest(target).hide();

		},

		PricingHandler: function(checked) {
			if(checked == "free") {
				NewProduct.PricingCleaner();
			}else if(checked == "fixed_price") {
				NewProduct.PricingCleaner("keep");
			}else if(checked == "pay_anything_from") {
				NewProduct.PricingCleaner("clear","keep");
			}else if(checked == "auction"){
				NewProduct.PricingCleaner("clear","clear","keep");
			}else {
				alert("Error please refresh the page");
			}
		},
		PricingCleaner: function(fixed, anything, auction) {
			    fixed   = fixed     || "clear";
	    		anything = anything || "clear";
	    		auction = auction   || "clear";

			if(fixed == "clear"){
				$("#product_total_amount").val('');	  
				$(".fp-fields").hide();
			}else if(fixed == "keep"){
				$(".fp-fields").show();
			}

			if(anything == "clear") {
				$("#product_pay_anything").val('');
				$(".panyf").hide();
			}else if(anything == "keep"){
				$(".panyf").show();
			}
			if(auction == "clear") {
				$("#product_auction_starting_price").val('');
				$("#product_auction_buy_it_now_price").val('');
				$(".auction-data").hide();
			}else if(auction == "keep"){
				$(".auction-data").show();
			}
		}
	};