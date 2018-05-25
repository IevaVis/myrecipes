module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_chef

  	def connect
  		self.current_chef = find_current_user
  	end

  	def disconnet
  	end


  	protected

		#this method returns current user
		#cookies.encrypted = in the collection of cookies which have been passed between client and server, the cookies beeing accessed are encrypted
		#cookies.encryoted - comes from sessions controller
  	def find_current_user
  		if current_chef = Chef.find_by(id: cookies.encrypted[:chef_id])
  			current_chef
  		else
  			reject_unauthorized_connection
  		end
  	end
  end
end
