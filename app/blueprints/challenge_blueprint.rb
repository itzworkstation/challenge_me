class ChallengeBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :description, :state, :challenge_type, :start_date, :end_date, :media_url
  
end