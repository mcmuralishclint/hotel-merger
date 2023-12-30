# frozen_string_literal: true

module Persist
  class BaseService
    def initialize(params)
      @params = params.with_indifferent_access
    end

    def validate_and_save; end

    private

    def validate_params
      {}
    end
  end
end
