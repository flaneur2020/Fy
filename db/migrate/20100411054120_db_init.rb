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
      t.text      :content
      t.integer   :user_id
      t.integer   :category_id
      t.timestamps
    end

    create_table :category do |t|
      t.string    :name
    end

    # init users
    User.create(
      :name=>'root', 
      :pass=>'123456')
    ssword=User.create(
      :name=>'ssword',
      :pass=>'aaaaaa')

    # init Posts
    100.times do |i|
      Post.create(
        :title=>"test post #{i}",
        :content=>'blah~',
        :user =>ssword
      )
    end

    Category.create do (
      :name => 'default'
    )
  end

  def self.down
      drop_table :users
      drop_table :posts
  end
end
