FactoryGirl.define do

  factory :user do
    username "TomHanks"
    password  "jd*nns(49Sf0"
    auth_token "SIMvls9esNQyx4WzFveH"
  end

  factory :secret do
    secret_message "This is a top secret message."
    user_id 1
  end
  
end