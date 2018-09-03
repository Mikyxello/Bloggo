module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end


  def photo
    if(params[:photo] == nil)
      @photo = Unsplash::Photo.search("nothing")
    else
      @photo ||= Unsplash::Photo.search(params[:photo])
    end
  end

  def show_photo1
    photo[0]['urls']['thumb']
  end
  def getLink1
    photo[0]['links']['download']
  end

  def show_photo2
    photo[1]['urls']['thumb']
  end
  def getLink1
    photo[1]['links']['download']
  end

  def show_photo3
    photo[2]['urls']['thumb']
  end
  def getLink1
    photo[2]['links']['download']
  end



end
