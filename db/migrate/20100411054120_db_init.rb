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
      t.integer   :parent_id
      t.timestamps
    end

    create_table :attaches do |t|
      t.integer   :user_id
      t.integer   :post_id
      t.timestamps
      # for paperclip
      t.string    :upload_file_name
      t.string    :upload_content_type
      t.integer   :upload_file_size  
      t.datetime  :upload_updated_at
    end

    # init users
    User.create(
      :name=>'root', 
      :pass=>'123456')
    ssword=User.create(
      :name=>'ssword',
      :pass=>'aaaaaa')

    root=Category.create(
      :name=>'root'
    )
    default=Category.create (
      :name=>'default',
      :parent=>root
    )
    blah=Category.create(
      :name=>'blah~',
      :parent=>root
    )
    blah2=Category.create(
      :name=>'blah2',
      :parent=>default
    )
    blah3=Category.create(
      :name=>'blah3',
      :parent=>default
    )

    # init Posts
    status=['draft', 'removed', 'published']
    categories=[root, default, blah]
    100.times do |i|
      Post.create do |p|
        p.title="test p #{i}"
        p.content='blah~'
        p.user=ssword
        p.category = categories[rand(3)]
        p.state = status[rand(3)]
      end
    end
  end

  def self.down
      drop_table :users
      drop_table :posts
      drop_table :categories
      drop_table :attaches
  end
end
