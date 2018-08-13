module Blog

  class RelationshipsController<BlogController


    def create
      author = Author.find(params[:followed_id])
      current_author.follow(author)
      redirect_to request.referrer
    end

    def destroy
      author = Relationship.find(params[:id]).followed
      current_author.unfollow(author)
      redirect_to request.referrer
    end


  end



end
