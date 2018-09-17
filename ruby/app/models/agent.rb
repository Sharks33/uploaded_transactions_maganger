class Agent < ApplicationRecord
  has_many :uploaded_seller_transactions, class_name: "UploadedTransaction", foreign_key: :listing_agent_id
  has_many :uploaded_buyer_transactions, class_name: "UploadedTransaction", foreign_key: :selling_agent_id

  def all_transactions
    transactions = UploadedTransaction.where("listing_agent_id = ? OR selling_agent_id = ?", id, id)
    transactions_by_date = transactions.sort_by { |t| t.selling_date || 0 }
    sorted_transactions = transactions_by_date.sort_by { |t| t.property_type == "land" || t.property_type == "mobile_home" ? 1 : 0 }
    return sorted_transactions
  end

  def recent_transactions
    all_transactions.where("selling_date > ?", 6.months.ago)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
