# set configues
set :username, "assignment2"
set :password, "new"
enable :sessions
# set :environment, :development

# when route not found
not_found do
"route is not available"
end

# home page
get '/' do
  erb :home
end

get '/home' do
  @title = "home page"
  erb :home
end

# about me
get '/about' do
  @title = "about page"
  erb :about
end

#contact info
get '/contact' do
  @title = "contact page"
  erb :contact
end

# student
get '/students' do
  @title = "Student Page"
  # reset the validStudent session status
  session[:validStudent] = ""
  @allStudents = Students.all
  erb :students
end

# create student entry
get '/createstudent' do
  if session[:admin] != true
    redirect to ('/login')
  else
    erb :createStudent
  end
end

post '/createstudent' do
  student = Students.new
  student.studentID = params[:studentID]
  student.firstname = params[:firstname]
  student.lastname = params[:lastname]
  student.birthday = params[:birthday]
  student.address = params[:address]
  # check if any one of the entry is invalid
  if params[:studentID].empty? || params[:firstname].empty? ||
    params[:lastname].empty? || params[:birthday].empty? ||
    params[:address].empty?
    session[:validStudent] = "invalid new student entry, please fill in every slots"
    redirect to ('/createstudent')
  else
    #other wise save the student record to db
    student.save
    redirect to ('/students')
  end
end

# update student info
post '/editstudent' do
  student = Students.get(session[:editID])

  student.update(:studentID => params[:studentID], :firstname => params[:firstname],
  :lastname => params[:lastname], :birthday => params[:birthday], :address => params[:address])
  redirect to ('/students')
end

# comment
get '/comment' do
  @title = "comment page"
  session[:validComment] = ""
  @allComments = Comments.all
  erb :comment
end

get '/createcomment' do
  if session[:admin] != true
    redirect to ('/login')
  else
    erb :createComment
  end
end

# create comment
post '/createcomment' do
  comment = Comments.new
  comment.name = params[:name]
  comment.title = params[:title]
  comment.content = params[:content]
  # check if any field is empty
  if params[:content].empty? || params[:name].empty? || params[:title].empty?
    session[:validComment] = "invalid comment entry, please fill in every slots"
    redirect to ('/createcomment')
  else
    # otherwise reset the validComment session and save the comment
    session[:validComment] = ""
    comment.save
    redirect to ('/comment')
  end

end

# specific comment
get '/comment/:id' do
  @cmt = Comments.get(params[:id])
  erb :specificComment
end

get '/students/:id' do
  @stud = Students.get(params[:id])
  erb :specificStudent
end

get "/editstudent" do
  erb :editStudent
end
#edit student
post '/students/edit/:id' do
  if session[:admin] == true
    @stud = Students.get(params[:id])
    session[:editID] = params[:id]
    erb :editStudent
  else
    erb :login
  end
end

# delete student
post '/students/delete/:id' do
  if session[:admin] == true
    student = Students.get(params[:id])
    student.destroy
    redirect to ('/students')
  else
    erb :login
  end
end

# video
get '/video' do
  @title = "video page"
  erb :video
end


# login page
get '/login' do
  @title = "login page"
  erb :login
end

# logon user
post '/login' do
  # if username and passwords are the same
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true # set admin status to true
    session[:validLogin] = ""
    @title = "home page"
    erb :home
  else
    session[:validLogin] = "invalid username/password, please try again"# set login error
    erb :login
  end
end

# logout page
get '/logout' do
  @title = "log out page"
  erb :logout
end

# logout from the system
post '/logout' do
  session[:admin] = false # set admin status to false
  redirect to ('/login')
end
