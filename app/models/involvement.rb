# == Schema Information
#
# Table name: involvements
#
#  id                 :integer          not null, primary key
#  teaching_module_id :integer
#  user_id            :integer
#  hours_cm           :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  description        :text
#  hours_td           :integer          default(0)
#  hours_tp           :integer          default(0)
#

class Involvement < ActiveRecord::Base
  belongs_to :teaching_module
  belongs_to :user

  def self.student_hours
    all.collect(&:student_hours).sum
  end

  def self.teacher_hours
    all.collect(&:teacher_hours).sum
  end

  def student_hours
    hours_cm + hours_td + hours_tp
  end

  def teacher_hours
    hours_cm + 2*hours_td + 3*hours_tp
  end

  def to_s
    "#{user} - #{teaching_module.code} (CM #{hours_cm}h, TD #{hours_td}, TP #{hours_tp})"
  end

end
