class HierarchyNotification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id
  field :type
  field :lecture_id
  field :subject_id
  field :space_id
  field :course_id
  field :status_id
  field :statusable_id
  field :statusable_type
  field :in_response_to_id
  field :in_response_to_type

  validates_presence_of :user_id
  validates_presence_of :type

  scope :by_subject, lambda { |id| where(:subject_id => id) }
  scope :by_type, lambda { |kind| where(:type => kind) }
  scope :answered, lambda { |answers|
    any_in(:status_id => answers.distinct(:in_response_to_id)).where(
      :type => "help") }

  def self.notification_exists?(hierar)
    @hierarchy = hierar

    conditions = {
      :user_id => @hierarchy.user_id,
      :status_id => @hierarchy.status_id,
      :statusable_id => @hierarchy.statusable_id,
      :statusable_type => @hierarchy.statusable_type,
      :in_response_to_id => @hierarchy.in_response_to_id,
      :in_response_to_type => @hierarchy.in_response_to_type,
      :lecture_id => @hierarchy.lecture_id,
      :subject_id => @hierarchy.subject_id,
      :space_id => @hierarchy.space_id,
      :course_id => @hierarchy.course_id,
      :type => @hierarchy.type
    }

    self.exists?(:conditions => conditions)
  end
end
