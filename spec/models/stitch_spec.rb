require 'spec_helper'

describe Stitch do

  let(:user) { FactoryGirl.create(:user) }
  before { @stitch = user.stitches.build(name: "Stitch 1", description: "The first stitch!") }

  subject { @stitch }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:file_url) }
  it { should respond_to(:rejected) }
  it { should respond_to(:notes) }

  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Stitch.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @stitch.user_id = nil }
    it { should_not be_valid }
  end

  describe "with description too long" do
    before { @stitch.description = "a" * 141 }
    it { should_not be_valid }
  end

end
