class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	# before_action :authenticate_user!



	# 管理者、顧客それぞれのログイン後の表示画面変更
	def after_sign_in_path_for(resource_or_scope)
		if resource_or_scope.is_a?(Admin)
			admin_top_path
		else
			my_page_path
		end
	end

	# 管理者、顧客それぞれのログアウト後の表示画面変更
	def after_sign_out_path_for(resource_or_scope)
		if resource_or_scope == :admin
			admin_session_path
		else
			root_path
		end
	end

	before_action :get_latest_tag

	def get_latest_tag
		@tags_all = Tag.order( created_at: :desc).limit(5)
	end

	protected

	def configure_permitted_parameters
		 devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end
end
