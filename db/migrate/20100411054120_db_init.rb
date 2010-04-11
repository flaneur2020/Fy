class DbInit < ActiveRecord::Migration
  def self.up

    create_table :users do |t|
        t.string    :name
        t.string    :pass
        t.integer   :role_id
        t.timestamp
    end

    create_table :roles do |t|
        t.string    :name
    end

    create_table :auths do |t|
        t.string    :name
        t.integer   :role_id
    end

    create_table :metas do |t|
        t.string    :title
        t.integer   :user_id
        t.integer   :obj_id
        t.string    :obj_type
        t.integer   :state
        t.timestamp
    end

    create_table :posts do |t|
        t.text      :content
    end
  end

  def self.down
      drop_table :users
      drop_table :roles
      drop_table :auths
      drop_table :metas
      drop_table :posts
  end
end
