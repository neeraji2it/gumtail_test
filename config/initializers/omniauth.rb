Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_APP_ID, FB_SEC_ID, {:scope => 'email, publish_actions, offline_access, publish_stream'} if Rails.env=="development"
  provider :facebook, FB_APP_ID_P, FB_SEC_ID_P, {:scope => 'email, publish_actions, offline_access, publish_stream'} if Rails.env=="production"
  provider :twitter, TW_APP_ID,TW_SEC_ID if Rails.env=="development"
  provider :twitter, TW_APP_ID_P,TW_SEC_ID_P if Rails.env=="production"
end