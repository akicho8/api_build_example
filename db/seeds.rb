["alice", "bob"].each do |name|
  p User.create!(:name => name)
end
