# frozen_string_literal: true

RSpec.describe Supplier::AcmeService do
  describe '#fetch_and_save_hotel_info' do
    let(:mock_hotels) do
      file_path = Rails.root.join('spec', 'mocks', 'acme_response.json')
      JSON.parse(File.read(file_path))
    end

    let(:acme_service) { described_class.new }

    before do
      allow(acme_service).to receive(:fetch_hotels).and_return(mock_hotels)
      allow(acme_service).to receive(:persist_raw_data)
    end

    it 'calls save_hotel_info with parsed hotels params' do
      acme_service.perform

      expect(acme_service).to have_received(:fetch_hotels)
      expect(acme_service).to have_received(:persist_raw_data).exactly(mock_hotels.size).times
    end
  end
end
