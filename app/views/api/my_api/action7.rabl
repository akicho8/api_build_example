collection User.all, :root => :result, :object_root => false
attribute :id, :name
node(:foo) do |user|
  user.id
end
