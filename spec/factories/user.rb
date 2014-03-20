FactoryGirl.define do
  factory :user do
    email "test@user.com"
    password "12345678"
    password_confirmation "12345678"
    factory :admin do
      is_admin true
    end
    factory :editor do
      is_editor true
    end
  end
end
