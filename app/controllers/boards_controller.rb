class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page]) #pageはkaminariのメソッド
  end

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"
      redirect_to board
    else
      redirect_to new_board_path, flash: {
        board: board, #flashでboardオブジェクトを返すことで、入力が失敗した時に値を保持できる。
        error_messages: board.errors.full_messages #エラーメッセージメソッド
      }
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
  end

  def update
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を編集しました"
      @board.update(board_params)
      redirect_to @board
    else
      redirect_to edit_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages #エラーメッセージメソッド
      }
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました"}
  end

  private #クラス外からは呼び出せない。

  def board_params
    params.require(:board).permit(:name, :title, :body, tag_ids: [])
    #requireとpermit。これをあらかじめ設定しておくことで、
    #仮に悪意のあるリクエスト（指定した以外のデータを送ってくる等）を受けた際に、
    #許可していない項目については変更されず、データの扱いがより安全になります。
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end
