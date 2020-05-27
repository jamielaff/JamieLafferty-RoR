require "rails_helper"

RSpec.feature Article, type: :model do

  describe "validations" do
    it "valid with valid attributes" do
      article = Article.new
      article.title       = "Test title"
      article.description = "Test description"
      article.user        = User.new
      expect(article).to be_valid
    end
  
    it "not valid without valid attributes" do
      article = Article.new
      article.title     = "Test"
      expect(article).to_not be_valid
    end
  end
  
  describe "scopes" do 
    it "only shows posts by admin" do
      admin_user          = User.new
      admin_user.username = "admin_username"
      admin_user.email    = "admin@email.com"
      admin_user.password = "password"
      admin_user.is_admin = true
      admin_user.save
      
      user            = User.new
      user.username   = "username"
      user.email      = "user@email.com"
      user.password   = "password"
      user.save

      admin_article             = Article.new
      admin_article.title       = "Admin title"
      admin_article.description = "Admin description"
      admin_article.user        = admin_user
      admin_article.save

      article             = Article.new
      article.title       = "User title"
      article.description = "User description"
      article.user        = user
      article.save

      expect(Article.by_admin.count).to eq(1)
      expect(Article.by_admin.first.title).to eq ("Admin title")
    end
  end
end
