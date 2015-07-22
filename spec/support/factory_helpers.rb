# require 'ffaker'
# 
# module FactoryHelpers
# 
#   def self.random_bool; random_in([true, false]) end
#   
#   def self.random_int range; range.to_a.shuffle.first end
# 
#   def self.random_name; Faker::Name.name end
# 
#   def self.random_company_name; Faker::Company.name end
# 
#   def self.random_email name=nil; "#{random_int(97..122).chr}.#{Faker::Internet.email name}" end
# 
#   def self.random_phone; Faker::PhoneNumber.phone_number end
# 
#   def self.random_contact_data
#     {
#       'name' => self.random_name,
#       'email' => self.random_email,
#       'phone_number' => self.random_phone,
#       'mobile_number' => self.random_phone
#     }
#   end
# 
#   def self.random_address
#     {
#       'street' => Faker::Address.street_address
#     }
#   end
# 
#   def self.random_in entries; entries.shuffle.first end
# 
#   # Only in ffaker
#   def self.random_title; Faker::Movie.title end
# 
#   def self.random_sentence; Faker::Lorem.sentence end
# 
#   def self.random_paragraph; Faker::Lorem.paragraph end
# 
# end
