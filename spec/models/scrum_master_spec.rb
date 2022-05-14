require 'rails_helper'

describe ScrumMaster do
  let(:user) { sign_up }

  describe 'validation' do
    let(:team_a) { create_team }
    let(:team_b) { create_team }

    it do
      sm = described_class.new(user: user)
      sm.add_team(team_a)
      sm.add_team(team_a)

      aggregate_failures do
        expect(sm).to_not be_valid
        expect(sm.errors[:base]).to include t_model_error(:scrum_master, :base, :duplicated_team)
      end
    end
  end
end
