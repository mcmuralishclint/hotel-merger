require 'rails_helper'

RSpec.describe Ingest::HotelsIngestionService do
  describe '#initialize' do
    context 'with valid suppliers' do
      it 'assigns valid suppliers to @suppliers' do
        service = Ingest::HotelsIngestionService.new(['acme', 'patagonia'])
        expect(service.instance_variable_get(:@suppliers)).to contain_exactly('acme', 'patagonia')
      end
    end

    context 'with "*" as suppliers' do
      it 'assigns all valid suppliers to @suppliers' do
        service = Ingest::HotelsIngestionService.new(['*'])
        expect(service.instance_variable_get(:@suppliers)).to eq(['acme', 'patagonia', 'paperflies'])
      end
    end

    context 'with invalid suppliers' do
      it 'assigns empty array to @suppliers' do
        service = Ingest::HotelsIngestionService.new(['invalid', 'another_invalid'])
        expect(service.instance_variable_get(:@suppliers)).to eq([])
      end
    end
  end

  describe '#ingest' do
    it 'calls fetch_and_save_hotel_info for each supplier' do
      acme_service = instance_double('Supplier::AcmeService')

      allow(Supplier::AcmeService).to receive(:new).and_return(acme_service)
      allow(acme_service).to receive(:perform)

      service = Ingest::HotelsIngestionService.new(['acme'])

      expect(acme_service).to receive(:perform)
      service.ingest
    end
  end
end
