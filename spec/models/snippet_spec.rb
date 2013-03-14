require 'spec_helper'

describe Snippet do
  it { should belong_to :user         }
  it { should belong_to :organization }
  it { should have_many :messages     }
end
