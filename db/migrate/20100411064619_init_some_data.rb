class InitSomeData < ActiveRecord::Migration
  def self.up
    User.new(:name=>'root', :pass=>'123456', :role_id=>0).save
    User.new(:name=>'ssword', :pass=>'aaaaaa', :role_id=>1).save
    User.new(:name=>'fleurer', :pass=>'aaaaaa', :role_id=>2).save
  end

  def self.down
  end
end
