class NotificationsController < ApplicationController
  require 'base64'

  before_action :notice_count,:todo_count,  only: [:index,:index_todo,:show]
  before_action :set_notification, only: [:dispatcher, :show]

  # お知らせ
  def index
    @notifications = Notification.where.not(action: 5 ).where("(receiver_id = ?)",current_user.id).order("created_at DESC")
  end

  def index_api
    @notifications = Notification.where.not(action: 5 ).where("(receiver_id = ?)",current_user.id).order("created_at DESC")
        respond_to do |format|
      format.json {@notifications}
    end
  end

  # やることリスト
  def index_todo
    @todo_list = Notification.where("(receiver_id = ?) && (action = ?) && (todo_status = ?)",current_user.id,5,0).order("created_at DESC")
  end

  def index_todo_api
    @todo_list = Notification.where("(receiver_id = ?) && (action = ?) && (todo_status = ?)",current_user.id,5,0).order("created_at DESC")
    respond_to do |format|
      format.json {@todo_list}
    end
  end

  # 表示内容の振り分け
  def dispatcher
    # 未読(false)の場合は、既読の状態にアップデートする
    @notification.update(checked: true) unless @notification.checked

    case @notification.action
    when 1 # 事務局からのお知らせなど
      redirect_to notification_path(@notification)
    when 2 # 取引ステータス変更時（購入〜取引完了まで）
      redirect_to product_trade_path(@notification.trade.product_id,@notification.trade_id)
    when 3 # 「いいね」された
      if @notification.product.sales_status_id == 2
        redirect_to product_path(@notification.product_id)
      else
        redirect_to selling_show_product_path(@notification.product_id)
      end
    when 4 # 「コメント」された
      redirect_to product_trade_path(@notification.trade.product_id,@notification.trade_id)
    when 5 # 「todo」の場合
      redirect_to product_trade_path(@notification.trade.product_id,@notification.trade_id)
    end
  end

  # 以下はactionが'1'(通知)だった場合のアクション
  def show
  end

  def new
    @Notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to :index
    else
      render :new
      return
    end
  end

private

 def notification_params
  params.require(:notification).permit(
    :sender_id,
    :receiver_id,
    :product_id,
    :trade_id, 
    :type,
    :title,
    :message,
    :checked,
  )
 end

 def set_notification
  @notification = Notification.find(params[:id])
 end

end