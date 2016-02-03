class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private
  end

  def update?
    !record.private && user || record.user == user || user.try(:admin?) || record.users.include?(user)
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user || user.try(:admin?)
  end

  class Scope
   attr_reader :user, :scope

   def initialize(user, scope)
     @user = user
     @scope = scope
   end

   def resolve
     wikis = []
     if user.present? && user.role == 'admin'
       wikis = scope.all
     elsif user.present? && user.role == 'premium'
       all_wikis = scope.all
       all_wikis.each do |wiki|
         if !wiki.private || wiki.user == user || wiki.users.include?(user)
           wikis << wiki
         end
       end
     else
       all_wikis = scope.all
       wikis = []
       all_wikis.each do |wiki|
         if !wiki.private || wiki.users.include?(user)
           wikis << wiki
         end
       end
     end
     wikis
   end
 end

end