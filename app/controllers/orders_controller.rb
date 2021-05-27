class OrdersController < ApplicationController
  before_action :check_logged_in
  before_action :load_products_from_cart,
                :check_user_chose_delivery_address, only: %i(new create)
  before_action :build_order, only: :create
  before_action :load_order, only: %i(show cancel)
  before_action :check_order_own_or_admin, only: :show
  before_action :check_order_own, :check_pending_order, only: :cancel

  def index
    @orders = current_user.orders.newest_first
                          .paginate page: params[:page],
                                    per_page: Settings.order.per_page
  end

  def show; end

  def new
    @shipping_cost = Settings.order.shipping_cost_default
  end

  def create
    save_new_pending_order @order
    if flash[:danger]
      flash[:danger] << @order.errors.full_messages.join(", ")
    else
      cart.clear
      flash[:success] = t "order.messages.create_success"
    end
    redirect_to root_path
  end

  def cancel
    save_canceled_rejected_order :canceled, @order
    respond_to do |format|
      format.html{redirect_to @order}
      format.js unless flash[:danger]
    end
  end

  private

  def build_order
    shipping_cost = Settings.order.shipping_cost_default
    @order = current_user.orders.new note: params[:order][:note],
                      delivery_address_id: @delivery_address.id,
                      shipping: shipping_cost,
                      total: (shipping_cost + @total_price)
    @products.each do |product|
      @order.order_details.build product_id: product.id,
                                quantity: product.quantity,
                                price: product.price
    end
  end

  def check_user_chose_delivery_address
    id = session[:delivery_address_id]
    return redirect_to shipping_path unless id

    @delivery_address = DeliveryAddress.find_by id: id,
                                                user_id: session[:user_id]
    return if @delivery_address

    session.delete :delivery_address_id
    redirect_to shipping_path
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "order.messages.not_exist"
    redirect_to orders_path
  end

  def check_order_own_or_admin
    byebug
    return if @order.user_id == session[:user_id] || current_user.admin?

    flash[:danger] = t "order.messages.only_owner"
  end

  def check_order_own
    return if @order.user_id == session[:user_id]

    flash[:danger] = t "order.messages.only_owner"
    redirect_to @orders
  end

  def check_pending_order
    return if @order.pending?

    flash[:danger] = t "order.messages.not_for_cancel"
    redirect_to @order
  end
end
