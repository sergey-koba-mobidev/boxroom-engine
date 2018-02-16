FactoryBot.define do
  factory :folder, class: Boxroom::Folder do
    sequence(:name) { |i| "test#{i}" }
    parent { Boxroom::Folder.where(:name => 'Root folder').first_or_create }
  end
end

FactoryBot.define do
  factory :group, class: Boxroom::Group do
    sequence(:name) { |i| "test#{i}" }
  end
end

FactoryBot.define do
  factory :share_link, class: Boxroom::ShareLink do
    emails 'email1@domain.com, email2@domain.com'
    association :user, factory: :user
    association :user_file, factory: :user_file
    link_expires_at { 2.weeks.from_now.end_of_day }
  end
end

FactoryBot.define do
  factory :user_file, class: Boxroom::UserFile do
    attachment { fixture_file }
    sequence(:attachment_file_name) { |i| "test#{i}.txt" }
    folder { Boxroom::Folder.where(:name => 'Root folder').first_or_create }
  end
end

FactoryBot.define do
  factory :user, class: Boxroom::User do
    sequence(:name) { |i| "test#{i}" }
    sequence(:email) { |i| "test#{i}@test.com" }
    password 'secret123'
    password_confirmation { |u| u.password }
    password_required true
    reset_password_token ''
    dont_clear_reset_password_token false
    remember_token ''
    is_admin false
  end
end

def fixture_file
  File.new("test/fixtures/textfile.txt")
end
