class Task < ActiveRecord::Base
  attr_accessor :data
  serialize :meta
  extend ActsAsTree::TreeWalker
  acts_as_tree

  def create_sub_task hash
    hash = { parent: self, processor: self.processor}.merge! hash
    Task.create! hash
  end
  
end
