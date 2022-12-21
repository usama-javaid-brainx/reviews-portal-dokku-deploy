# frozen_string_literal: true

module Statusable
  extend ActiveSupport::Concern

  included do
    enum status: [:active, :inactive, :blocked, :on_hold]

    after_validation :activate
  end

  def status_text
    return status unless respond_to?(:status_texts)

    status_texts[status.to_sym]
  end

  private

  def activate
    self.status = :active if status.nil?
  end
end
