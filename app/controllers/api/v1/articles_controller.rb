module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only:[:show, :destroy, :update]
      def index
        @articles = Article.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded articles', data:@articles}, status: :ok
      end

      def show
        render json: {status: 'SUCCESS', message: 'Loaded article', data:@article}, status: :ok
      end

      def create
        @article = Article.new(article_params)

        if @article.save
          render json: {status: 'SUCCESS', message: 'Saved article', data:@article}, status: :ok
        else
          render json: {status: 'ERROR', message:'Article not saved', data:@article.error},status: :unprocessable_entity
        end

      end

      def update
        @article.update(article_params)
      end

      def destroy
        @article.destroy
        render json: {status: 'SUCCESS', message: 'Deleted article', data:@article}, status: :ok
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :body)
      end
    end
  end
end
