require 'rails_helper'

describe User do
  describe 'callbacks' do
    subject { described_class.create(email: "zozo@gmail.com", password: "zozozo") }

    it 'calls ::create_records on Profile' do
      expect(Profile).to receive(:create_records)
      subject
    end
  end
end
