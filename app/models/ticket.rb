# frozen_string_literal: true

require "uri"

class Ticket
  include Mongoid::Document

  field :name, type: String
  field :seat_id_seq, type: String
  field :address, type: String
  field :price_paid, type: BigDecimal
  field :email_address, type: String

  index({ seat_id_seq: 1 }, { unique: true })

  validates :name, :seat_id_seq, :address, :price_paid, :email_address, presence: true
  validates :seat_id_seq, uniqueness: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :price_paid, numericality: { greater_than_or_equal_to: 0 }

  # Coerce raw form input ("12.50") into a BigDecimal without crashing on
  # malformed values — malformed input lands in the validations instead.
  def price_paid=(value)
    self[:price_paid] = if value.is_a?(BigDecimal)
                          value
                        elsif value.blank?
                          nil
                        else
                          BigDecimal(value.to_s)
                        end
  rescue ArgumentError, TypeError
    self[:price_paid] = nil
  end
end