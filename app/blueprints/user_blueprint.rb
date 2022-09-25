class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email
  field(:avatar) do |user|
    user.avatar.url
  end
  field(:access_token) do |_user, option|
    option[:access_token]
  end
end