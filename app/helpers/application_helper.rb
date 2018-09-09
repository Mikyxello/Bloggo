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
      @photo = Unsplash::Photo.search("blog")
    else
      @photo ||= Unsplash::Photo.search(params[:photo])
    end
  end

  def show_photo1
    if photo[0].nil?
      Unsplash::Photo.random()['urls']['thumb']
    else
    photo[0]['urls']['thumb']
    end
  end
  def getLink1
    if photo[0].nil?
      Unsplash::Photo.random()['links']['download']
    else
    photo[0]['links']['download']
    end
  end

  def show_photo2
    if photo[1].nil?
      Unsplash::Photo.random()['urls']['thumb']
    else
    photo[1]['urls']['thumb']
    end
  end
  def getLink2
    if photo[1].nil?
      Unsplash::Photo.random()['links']['download']
    else
    photo[1]['links']['download']
    end
  end

  def show_photo3
    if photo[3].nil?
      Unsplash::Photo.random()['urls']['thumb']
    else
    photo[3]['urls']['thumb']
    end
  end
  def getLink3
    if photo[3].nil?
      Unsplash::Photo.random()['links']['download']
    else
    photo[3]['links']['download']
    end
  end



end
