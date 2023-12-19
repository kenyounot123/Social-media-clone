class AddPolyAssociation < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :commentable, polymorphic: true
  end
end
