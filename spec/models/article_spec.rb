require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should belong_to(:user).optional }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:slug) }
end
