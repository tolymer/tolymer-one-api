class Queries::Event < Queries::BaseQuery
  type Types::EventType, null: false

  argument :token, String, required: true

  def resolve(token:)
    ::Event.find_by!(token: token)
  end
end
