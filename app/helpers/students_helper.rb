module StudentsHelper
  def image_url(student)
    if student.url.present?
    elsif student.email.present?
      require 'digest/md5'
      digest = Digest::MD5.hexdigest(student.email).downcase
      student.url = "http://gravatar.com/avatar/#{digest}?s=150"
    else
      student.url = "http://gravatar.com/avatar/avatar.jpg?s=150"
    end
    student.url
  end
end