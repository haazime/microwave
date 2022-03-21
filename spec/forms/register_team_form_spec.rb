require 'rails_helper'

describe RegisterTeamForm do
  it do
    form = described_class.new(
      name: 'team name',
      roles_attributes: {
        '0' => { 'role' => 'product_owner' },
        '1' => { 'role' => '' },
        '2' => { 'role' => 'scrum_master' },
      }
    )
    expect(form).to be_valid
  end
end
