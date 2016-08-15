class Html::CheckCode

 include Service

 attr_reader :student, :group, :item
 def initialize(student, group, item)
   @student = student
   @group = group
   @item = item
 end

 def call

	item_type=4
	badge=Badge.active.where(badge_type_id: 1).last
	description = "Win " + badge.name.to_s + " per an awesome job"
 	AddBadgeToStudent.call(badge.id,@student,item_type,@group,@item,description)

 end

end
