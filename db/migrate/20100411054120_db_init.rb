class DbInit < ActiveRecord::Migration
  def self.up

    # buddy , take it easy
    create_table :users do |t|
        t.string    :name
        t.string    :pass
        t.timestamps
    end

    create_table :posts do |t|
      t.string    :title
      t.integer   :user_id
      t.text      :content
      t.timestamps
    end

    User.create(
      :name=>'root', 
      :pass=>'123456')
    ssword=User.create(
      :name=>'ssword',
      :pass=>'aaaaaa')

    100.times do |i|
      Post.create(
        :title=>"test post #{i}",
        :content=>'blah~'
        :user =>ssword
      )
    end
  end

  def self.down
      drop_table :users
      drop_table :posts
  end
end
