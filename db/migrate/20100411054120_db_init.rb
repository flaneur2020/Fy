class DbInit < ActiveRecord::Migration
  def self.up

    # buddy , take it easy
    create_table :users do |t|
        t.string    :name
        t.string    :pass
        t.timestamps
    end

    create_table :posts do |t|
      t.string    :titile
      t.integer   :user_id
      t.text      :content
      t.timestamps
    end

    User.create(
      :name=>'root', 
      :pass=>'123456')
    User.create(
      :name=>'ssword',
      :pass=>'aaaaaa')
  end

  def self.down
      drop_table :users
      drop_table :posts
  end
end
