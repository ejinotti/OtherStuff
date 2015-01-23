class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :user_id, :presence => true
  validates :status, :presence => true, :inclusion => { :in => STATUSES }
  
  validate :overlapping_approved_requests

  after_initialize :set_status

  belongs_to :cat

  belongs_to(
    :requester,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  def approve!
    self.status = "APPROVED"

    CatRentalRequest.transaction do
      self.save!
      overlapping_pending_requests.each do |req|
        req.update!(:status => "DENIED")
      end
    end

    nil
  end


  def deny!
    self.status = "DENIED"
    self.save!
  end


  def overlapping_requests
    requests = Cat.find(self.cat_id).cat_rental_requests
    requests.select do |req|
      !(self.end_date < req.start_date || req.end_date < self.start_date)
    end
  end


  def overlapping_pending_requests
    overlapping_requests.select { |req| req.status == "PENDING" }
  end


  def overlapping_approved_requests
    overlapping_requests.each do |req|
      if [self, req].all? { |el| el.status == "APPROVED"}
        errors[:base] << "That cat is busy during at least one of those days"
      end
    end

    nil
  end


  def set_status
    self.status ||= "PENDING"
  end
end
