class UploadedTransaction < ApplicationRecord
  belongs_to :listing_agent, required: false, class_name: "Agent"
  belongs_to :selling_agent, required: false, class_name: "Agent"

  scope :single_family_homes, -> { where(property_type: "single_family_home") }
  scope :sold, -> { where(status: "sold") }

  validates :address, presence: { message: "Please provide a valid street address."}
  validates :city, presence: { message: "Please provide a valid City."}
  validates :state, presence: { message: "Please provide a valid State."}
  validates :zip, format: { with: /\A\d{5}-\d{4}|\A\d{5}\z/, message: "Please provide valid zip code! Example: 12345 or 12345-1234" }
  validates :listing_date, format: { with: /\A\d{4}\-\d{1,2}\-\d{1,2}\z/, message: "Please provide valid listing date. Format: yyyy-mm-dd" }
  validates :listing_price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Please provide the listing price in USD. Example: 500000" }, numericality: { greater_than: 0}
  validates :selling_date, format: { with: /\A\d{4}\-\d{1,2}\-\d{1,2}\z/, message: "Please provide valid selling date. Format: yyyy-mm-dd" }
  validates :selling_price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Please provide the selling price in USD. Example: 500000" }, numericality: { greater_than: 0}

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end
end
