require "spec_helper"

describe PostsController do

  let(:valid_attributes) { { :name => "test name", :subject => "test subject" } }
  let(:invalid_attributes) { { :name => "", :subject => "" } }
  let(:valid_session) { {} }

  describe "GET INDEX" do
    describe "With Posts" do
      it "Assigns all posts to @posts and render template" do
        post = FactoryGirl.create(:post)
        get :index, {}, valid_session
        assigns(:posts).should eq([post])
        response.should render_template("index")  
      end
    end
    describe "Without Posts" do
      it "Assigns all posts to @posts and render template" do
        get :index, {}, valid_session
        assigns(:posts).should eq([])
        response.should render_template("index")
      end
    end
  end

  describe "Get SHOW" do
    describe "With Valid Post" do
      it "Assigns post to @post and render template show" do
        post = FactoryGirl.create(:post)
        get :show, { :id => post.to_param }, valid_session
        assigns(:post).should eq(post)
        response.should render_template("show")
      end
    end
  end

  describe "Get NEW" do
    it "Assigns new post to @post and render template new" do
      get :new, {}, valid_session
      assigns(:post).should be_a_new(Post)
      response.should render_template("new")
    end
  end

  describe "Get EDIT" do
    it "Assigns post to @post" do
      post = FactoryGirl.create(:post)
      get :edit, { :id => post.to_param }, valid_session
      assigns(:post).should eq(post)
      response.should render_template("edit")
    end
  end

  describe "Post CREATE" do
    describe "With Valid Params" do
      it "Saves Post and redirect to show" do
        expect {
          post :create, { :post => valid_attributes }, valid_session
        }.to change(Post, :count).by(1)
        assigns(:post).should be_a(Post)
        assigns(:post).should_not be_a_new(Post)
        response.should redirect_to(Post.last)
      end
    end
    describe "Without Valid Params" do
      it "Saves Post and redirect to show" do
        expect {
          post :create, { :post => invalid_attributes }, valid_session
        }.to change(Post, :count).by(0)
        assigns(:post).should be_a(Post)
        assigns(:post).should be_a_new(Post)
        response.should render_template("new")
      end
    end
  end

  describe "Put UPDATE" do
    describe "With Valid Params" do
      it "updates post" do
        post = FactoryGirl.create(:post)
        put :update, { :id => post.to_param, :post => valid_attributes }, valid_session
        assigns(:post).should be_a(Post)
        post.reload
        post.name.should == valid_attributes[:name]
        post.subject.should == valid_attributes[:subject]
        response.should redirect_to(post)
      end
    end
    describe "With InValid Params" do
      it "will not update post" do
        post = FactoryGirl.create(:post)
        put :update, { :id => post.to_param, :post => invalid_attributes }, valid_session
        assigns(:post).should be_a(Post)
        post.reload
        post.name.should_not == invalid_attributes[:name]
        post.subject.should_not == invalid_attributes[:subject]
        response.should render_template("edit")
      end
    end
  end

  describe "Get DESTROY" do
    it "Destroy the post and redirect to index" do
      post = FactoryGirl.create(:post)
      expect {
        get :destroy, { :id => post.to_param }, valid_session
      }.to change(Post, :count).by(-1)
      response.should redirect_to(posts_path)
    end
  end

end
