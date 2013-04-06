########################
# From IRB or Pry:   
#    require './harness'
# then have fun.
########################

require 'rubygems'
require 'logger'
require 'active_record'

DB_NAME="foo"
ActiveRecord::Base.logger = Logger.new STDOUT
ActiveRecord::Base.establish_connection(:adapter => "postgresql", :database => DB_NAME)

########################
# Play Below. 
#
########################

ActiveRecord::Migration.create_table :papers do |t|
  t.string :name
end rescue puts "* Table 'papers' already exists."

ActiveRecord::Migration.create_table :votes do |t|
  t.integer :paper_id
end rescue puts "* Table 'votes' already exists."

class Paper < ActiveRecord::Base
  has_many :votes
end

class Vote < ActiveRecord::Base
  belongs_to :paper
end

#10.times { Paper.create(name: "Paper #{rand(1000)}")}
#100.times { Vote.create(paper_id: rand(10) )}

#Paper.joins(:votes).select("papers.name, COUNT(votes.id) as vote_count").group("papers.name").order("vote_count DESC")
