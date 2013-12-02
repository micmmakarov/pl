Rails.application.config.middleware.use OmniAuth::Builder do

  provider :twitter, '9lLGY0mzERNrzsBcPRXMQ', 'y8MXFCpetLHstiXk46SxrwlY5S78BaEoj5a3Or2nj7s'
  #provider :linked_in, '54lpcvck0g3c', '48fK1J3k9nw6Pp51'

  #development
  provider :facebook, '222424071230782', '902cce4522a3185b00a9bf7fa83f5334' if Rails.env.development?
  if Rails.env.production?
    if ENV['STAGING'] == 'YES'
      #staging
      provider :facebook, '459708810772153', '0b11be16b1398feea828a92243afdf7a'
    else
      #production
      provider :facebook, '765586176788452', 'c40acabc9d8e32fc46bfb042126503d7'
    end
  end

end