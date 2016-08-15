module Service
 extend ActiveSupport::Concern

 included do
   def self.call(*args)
     new(*args).call
   end
 end

 class Success
   def success?
     true
   end
 end


 class Error < Struct.new(:errors)
   def success?
     false
   end
 end

end
