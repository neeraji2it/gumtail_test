window.Store = 
	initialize: ->
		Store.events()
		Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
		Store.setupForm()

	setupForm: ->
		$('#new_order').submit ->
		  $('input[type=submit]').attr('disabled', true)
		  if $('#card_number').length
		    Store.processCard()
		    false
		  else
		    true

	processCard: ->
		card =
		  number: $('#card_number').val()
		  cvc: $('#cvv').val()
		  expMonth: $('#card_month').val()
		  expYear: $('#card_year').val()
		Stripe.createToken(card, Store.handleStripeResponse)

	handleStripeResponse: (status, response) ->
		if status == 200
		  $('#order_stripe_card_token').val(response.id)
		  $('#new_order')[0].submit()
		else
		  $('#stripe_error').text(response.error.message)
		  $('input[type=submit]').attr('disabled', false)
  
	events: ->
		# Recommend click event
		# --------------------------------------------------	
		$(".something").on 'click', (e)->
		 	alert 'Testing 123.'
		 	e.preventDefault()