Rails.configuration.stripe = {
  :publishable_key => "pk_test_Bet0Aa9ZKcfUYRIuxPGQztbi",
  :secret_key      => "sk_test_dVkQ8C79rcYHKnSIzB485kVC"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]