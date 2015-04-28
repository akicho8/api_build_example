["alice", "bob", "carol"].each do |name|
  p User.create!(:name => name)
end
