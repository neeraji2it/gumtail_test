require 'spec_helper'

describe Comment do
  before(:each) do
    @comment = Comment.new
  end
  it { should validate_presence_of(:content) }
  it { should belong_to(:order) }
end
