# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingest::HotelsIngestionService do
  describe '#initialize' do
    context 'with valid suppliers' do
      it 'assigns valid suppliers to @suppliers' do
        service = Ingest::HotelsIngestionService.new(%w[acme patagonia])
        expect(service.instance_variable_get(:@suppliers)).to contain_exactly('acme', 'patagonia')
      end
    end

    context 'with "*" as suppliers' do
      it 'assigns all valid suppliers to @suppliers' do
        service = Ingest::HotelsIngestionService.new(['*'])
        expect(service.instance_variable_get(:@suppliers)).to eq(%w[acme patagonia paperflies])
      end
    end

    context 'with invalid suppliers' do
      it 'assigns empty array to @suppliers' do
        service = Ingest::HotelsIngestionService.new(%w[invalid another_invalid])
        expect(service.instance_variable_get(:@suppliers)).to eq([])
      end
    end
  end

  describe '#ingest' do
    it 'calls fetch_and_save_hotel_info for each supplier' do
      acme_service = instance_double('Supplier::AcmeService')
      merge_service = instance_double('Merge::HotelsMergeService')

      allow(Supplier::AcmeService).to receive(:new).and_return(acme_service)
      allow(acme_service).to receive(:perform)

      allow(Merge::HotelsMergeService).to receive(:new).and_return(merge_service)
      allow(merge_service).to receive(:perform).and_return([])

      service = Ingest::HotelsIngestionService.new(['acme'])

      expect(acme_service).to receive(:perform)
      service.ingest
    end
  end
end
