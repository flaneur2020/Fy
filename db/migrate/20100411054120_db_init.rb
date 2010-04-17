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
      t.string    :state,       :default=>'draft'
      t.timestamps
    end

    create_table :categories do |t|
      t.string    :name
    end

    # init users
    User.create(
      :name=>'root', 
      :pass=>'123456')
    ssword=User.create(
      :name=>'ssword',
      :pass=>'aaaaaa')

    default=Category.create (
      :name=>'default'
    )
    Category.create(
      :name=>'blah~'
    )

    # init Posts
    status=['draft', 'removed', 'published']
    100.times do |i|
      Post.create do |p|
        p.title="test p #{i}"
        p.content='blah~'
        p.user=ssword
        p.category = default
        p.state = status[i%3]
      end
    end
  end

  def self.down
      drop_table :users
      drop_table :posts
      drop_table :categories
  end
end
