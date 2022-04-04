class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:new,:create]
    def new 
        @post = Post.new
    end

    def create 

        id_post=params[:id]
        title = params[:title]
        description = params[:description]
        publication_date = Time.now#.strftime('%F')

        image = nil
        image = save_file(params[:image],'images_post') if id_post.blank?
        @post = Post.new if id_post.blank?
        @post = Post.find(id_post) if !id_post.blank?
        @post.title = title
        @post.description = description
        @post.image_post = image if id_post.blank?
        @post.author = current_user.email
        @post.publication_date = publication_date
        @post.save

        redirect_to '/'
    end
    
    def edit
        id_post=params[:id]
        @post = Post.find(id_post) if !id_post.blank?
    end

    def index
        @post=Post.all
    end

    def my_post
        @post=Post.where('author=?', current_user.email)
    end

    def view_post
        id_post=params[:id]
        @post = Post.find(id_post) if !id_post.blank?
    end

    def export_post
        @post = Post.all
        time=Time.zone.now
        date=time.strftime('%b%d%Y')
        respond_to do |format|
            format.html
    format.xlsx{
        response.headers['Content-Disposition'] = "attachment; filename=All_post_#{date}#{time}.xlsx"
      }
        end
      end

    private

    def save_file(file,folder_img)
            ########SAVE images
            folder = "#{Rails.root}/public/#{folder_img}"
            name_file = (Time.new.to_s+'_'+file.original_filename).gsub(' ','')
            path = File.join(folder, name_file)
            File.open(path, "wb") { |f| f.write(file.read) };
            ################
            path_save = '/'+folder_img+'/'+name_file
            return path_save 
    end
    def delete_file(img)
        img_r="#{img}"
        if !img_r.blank?
          img = "#{Rails.root}/public/#{img}"  
          File.delete(img) if File.exist?(img)
        end
    end

end
