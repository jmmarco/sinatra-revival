require 'sinatra'
require 'sqlite3'
# use Rack::Static, :urls => ["/css", "/images"], :root => "/assets"

# set :static, true
# set :root, File.dirname(__FILE__)
# set :public, 'assets'

set :public_folder, File.dirname(__FILE__) + '/assets'


db = SQLite3::Database.new('db/books.db')
db.results_as_hash = true

get '/' do
  redirect '/books'
end

get '/books' do
  @books = db.execute('select * from books')
  erb :index
end

# Add a book
get '/books/new' do
  erb :new
end

post '/books' do
  if params[:book_cover].nil?
    params[:book_cover] = 'images/book-cover.svg'
  end
  @book = db.execute('insert into books (title, author, book_cover) values (?, ?, ?)', params[:title], params[:author], params[:book_cover])
  redirect '/'
end

# Search books
get '/books/search' do
  erb :search
end

post '/books/search' do
  @books = db.execute("select * from books where title like ?", "%#{params[:search]}%")

  if !@books.empty?
    p @books
    erb :search
  else
    @error = "Sorry, no books by the title #{params[:name]} found."
    erb :search
  end
end

# Delete a book
delete "/books/:id" do
  @book = db.execute('delete from books where id = ?', params[:id])
  redirect '/'
end

# Get a book
get '/books/:id' do
  @book = db.execute('select * from books where id = ?', params[:id])
  @book = @book.first
  erb :show
end

# Edit a book
get '/books/:id/edit' do
  @book = db.execute('select * from books where id = ?', params[:id])
  # Use .first because the db.execute returns an array
  @book = @book.first
  erb :edit
end

patch '/books/:id' do
  p params
  @book = db.execute('update books set title = ?, author = ?, book_cover = ? where id = ?', params[:title], params[:author], params['book-cover'], params[:id])
  redirect "/books/#{params[:id]}"
end
