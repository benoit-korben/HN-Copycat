# app/controllers/reactions_controller.rb
class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment

  def create
    @reaction = @comment.reactions.find_or_initialize_by(
      user: current_user,
      reaction_type: reaction_params[:reaction_type]
    )

    if @reaction.persisted?
      @reaction.destroy
    else
      @reaction.save
    end

    render json: {
      reactions_html: render_to_string(
        partial: 'comments/reactions',
        locals: { comment: @comment },
        formats: [:html]
      )
    }
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def reaction_params
    params.require(:reaction).permit(:reaction_type)
  end
end
