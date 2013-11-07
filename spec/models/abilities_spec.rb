require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  context 'admin' do
    before do
      @admin = FactoryGirl.create(:admin)
      @ability = Ability.new(@admin)
      @user = FactoryGirl.create(:american_user)
    end

    it 'should be able to do anything' do
      @ability.should be_able_to(:manage, :all)
    end

    it 'should be able to change bicycle status' do
      @ability.should be_able_to(:change_status, @bicycle)
    end
  end

  context 'signed-in user' do
    before do
      @user = FactoryGirl.create(:american_user)
      @ability = Ability.new(@user)
      @bicycle = FactoryGirl.create(:bicycle, user_id: @user.id)
    end

    it 'should not be able to approve a listing' do 
      @bicycle.approved = true
      @ability.should_not be_able_to(:change_status, @bicycle)
    end

    it 'should be able to update an approved listing' do
      @bicycle.update(approved: true)
      @ability.should be_able_to(:update, @bicycle)
    end

    it 'should be able to update other parts of the listing' do
      @bicycle.color = 'blue'
      @ability.should be_able_to(:update, @bicycle)
    end

    it 'should be able to fill out the new bicycle form' do
      @ability.should be_able_to(:new, @bicycle)
    end

    it 'should be able to register a bike' do
      @ability.should be_able_to(:create, @bicycle)
    end

    it 'should be able to edit a current listing' do
      @ability.should be_able_to(:edit, @bicycle)
    end

    it 'should not be able to edit a listing that is not their own' do
      @bicycle.user_id += 1
      @ability.should_not be_able_to(:edit, @bicycle)
    end

    it 'should not be able to update a listing that is not their own' do
      @bicycle.user_id += 1
      @ability.should_not be_able_to(:update, @bicycle)
    end

    it 'should not be able to access another users profile page' do
      @user.id += 1
      @ability.should_not be_able_to(:show, @user)
    end

    it 'should not be able to edit any other users profile info' do
      @user.id += 1
      @ability.should_not be_able_to(:edit, @user)
    end

    it 'should not be able to update any other users profile info' do
      @user.id += 1
      @ability.should_not be_able_to(:update, @user)
    end
  end

  context 'all users' do
    before do
      @users = [User.new, FactoryGirl.create(:american_user), FactoryGirl.create(:admin)]
      @user = FactoryGirl.build(:american_user)
      @bicycle = FactoryGirl.create(:bicycle)
    end

    it 'can view a bicycle page' do
      @users.each do |user|
        ability = Ability.new(user)
        ability.should be_able_to(:show, @bicycle)
      end
    end

    it 'can search for bicycles' do
      @users.each do |user|
        ability = Ability.new(user)
        ability.should be_able_to(:index, @bicycle)
      end
    end

    it 'can visit the new user page' do
      @users.each do |user|
        ability = Ability.new(user)
        ability.should be_able_to(:new, @user)
      end
    end

    it 'can create a user' do
      @users.each do |user|
        ability = Ability.new(user)
        ability.should be_able_to(:create, @user)
      end
    end
  end
end
