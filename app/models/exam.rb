class Exam < ApplicationRecord
  has_many :question_exams, dependent: :destroy

  belongs_to :user
  belongs_to :category

  validates :category, presence: true
  validates :user, presence: true
  validates :test_time, presence: true

  scope :recent, ->{order created_at: :desc}

  after_create :create_user_create_exam_activity

  def create_user_create_exam_activity
    action_type = Settings.activity.action_type.create_exam
    user.activities.create target_type:
      Settings.activity.target_type.create_relationship,
      target_id: exam.id, action_type: action_type
  end
end
