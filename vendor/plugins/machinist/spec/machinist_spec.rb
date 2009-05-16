require File.dirname(__FILE__) + '/spec_helper'
require 'machinist'

class Base
  include Machinist

  attr_accessor :invalid

  def save!
    raise "Invalid record" if @invalid
    save
  end

  def save;   @saved    = !@invalid;  end
  def reload; @reloaded = true; self; end
  
  def saved?;    @saved;    end
  def reloaded?; @reloaded; end

  def new_record?
    !@saved
  end
end

class Post < Base
  attr_accessor :title
  attr_accessor :body
end

class Comment < Base
  attr_accessor :post
  attr_accessor :author
  attr_accessor :body
end

Post.blueprint do
  title "An Example Post"
  body  { "The quick brown fox." }
end

Comment.blueprint do
  post
  author "Fred Bloggs"
  body   "Just a comment."
end

Comment.blueprint :bob do
  post
  author "Bob"
  body "Just a comment."
end

describe Machinist do
  describe "calling make with no arguments" do
    before do
      @post = Post.make
    end
    
    it "should set a field from a constant in the blueprint" do
      @post.title.should == "An Example Post"
    end
  
    it "should set a field from a block in the blueprint" do
      @post.body.should == "The quick brown fox."
    end
    
    it "should save the object" do
      @post.should be_saved
    end
    
    it "should reload the object" do
      @post.should be_reloaded
    end
  end
  
  it "should override a field from the blueprint with a parameter" do
    post = Post.make(:title => "A Different Title")
    post.title.should == "A Different Title"
  end
  
  it "should override a field from the blueprint with nil" do
    post = Post.make(:title => nil)
    post.title.should be_nil
  end

  it "should return invalid object from #make!" do
    post = Post.make!(:invalid => true)
    post.should_not be_saved
    post.should_not be_reloaded
  end

  it "should create an associated object for a field with no arguments in the blueprint" do
    comment = Comment.make
    comment.post.should_not be_nil
  end

  it "creates an object from a non-default blueprint" do
    comment = Comment.make(:bob)
    comment.author.should == 'Bob'
  end
end
