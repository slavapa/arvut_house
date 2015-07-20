module SessionsHelper

  def sign_in(user)
    remember_token = Person.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Person.hash(remember_token))
    self.current_user = user
  end


  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = Person.hash(cookies[:remember_token])
    @current_user ||= Person.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def signed_in?
    !current_user.nil?
  end
  
  def admin_user?
    signed_in? && current_user.admin?
  end

  def is_current_user_authorized_by_person?(user)
    admin_user? || current_user?(user)
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  Person.hash(Person.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def redirect_back_or(default)
    if signed_in?
      redirect_to(session[:return_to] || root_url)
    else
      redirect_to(root_url)
    end
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
  
  def store_current_event_id(event_id)
    session[:current_event_id] = event_id
  end
  
  def get_current_event_id
    session[:current_event_id]
  end
  
  def delete_current_event_id(event_id)
    session.delete(:current_event_id)
  end
  
  def check_current_user_admin
    if current_user.nil? || !current_user.admin?
      redirect_to(root_url, notice: t(:not_authorized) ) 
    end
  end

  def check_current_user_correct
    if current_user.nil? || (!current_user.admin? && !current_user?(current_user))
      redirect_to(root_url, notice: t(:not_authorized) ) 
    end
  end
  
  def check_current_user_correct
    if current_user.nil? || (!current_user.admin? && !current_user?(current_user))
      redirect_to(root_url, notice: t(:not_authorized) ) 
    end
  end
  
  def authorize_current_user_by_person(personId)
    if current_user.nil? || (!current_user.admin? && !current_user?(personId))
      redirect_to(root_url, notice: t(:not_authorized) ) 
    end
  end
  
  def store_current_payment_id(payment_id)
    session[:current_payment_id] = payment_id
  end
  
  def get_current_payment_id
    session[:current_payment_id]
  end
  
  def delete_current_payment_id(payment_id)
    session.delete(:current_payment_id)
  end
end
