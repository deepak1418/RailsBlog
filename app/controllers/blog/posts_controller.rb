module Blog

   class PostsController < BlogController
     # before_action :set_test, only: [:author]

     # GET /posts
      # GET /posts.json
      def index
       @posts=storage.list_for(params[:page],params[:tag])
        #  user = Post.find_by  (params[:author_id])
        # @author = user.author

      end


      # GET /posts/1
      # GET /posts/1.json
      def show
        @post = storage.friendly.find(params[:id])

      end

      def author
        @author = Author.find(params[:id])
        @posts=@author.posts
      end


      def following
        @title = "Following"
        @author  = Author.find(params[:id])
        @authors = @author.following
      end

      def followers
        @title = "Followers"
        @author = Author.find(params[:id])
        @authors = @author.followers.paginate(page: params[:page])
        # render 'show_follow'
      end


      private
     def storage
       Post.published
     end
     # def set_test
     #   @author = Author.find(params[:id])
     # end
   end


end
