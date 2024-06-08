module ControllerMacros
  def disable_csrf_protection
    allow_any_instance_of(ActionController::Base).to receive(:verify_authenticity_token).and_return(true)
  end
end
