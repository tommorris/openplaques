# This class represents a connection between a Person and a Role.
# === Associations
# * Person - the person to whom this connection applies
# * Role - the role referenced in this connection.
class PersonalRole < ActiveRecord::Base

  validates_uniqueness_of :person_id, :scope => :role_id
  validates_presence_of :role_id, :person_id

  belongs_to :person, :counter_cache => true
  belongs_to :role, :counter_cache => true

end
