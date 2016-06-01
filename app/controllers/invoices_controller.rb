class InvoicesController < ApplicationController

  def index
    if current_user.restaurant_worker?
      if request.xhr?
        @restaurant = Restaurant.find(params[:restaurant_id])
        @orders = @restaurant.orders.where("status ? 'invoiced'")
        @invoices = @orders.map { |order| order.invoice }
        render @invoices
      else
        @restaurants = current_user.restaurants
        @orders = @restaurants.map { |restaurant| restaurant.orders.where("status ? 'invoiced'") }.flatten
        @invoices = @orders.map { |order| order.invoice }
      end
    elsif current_user.supplier_worker?
      @supplier = current_user.suppliers.first
      if request.xhr?
        @invoices = Invoice.joins(order: :restaurant).where("restaurants.name ilike ? AND orders.supplier_id = #{@supplier.id}", "%#{params[:search]}%")
        render @invoices
      else
        @invoices = @supplier.invoices
      end
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @order = Order.find(params[:order_id])
    @invoice_items = @invoice.invoice_items
  end

  def create
    @invoice = Invoice.new
    @invoice.user_id = current_user.id
    @invoice.order_id = params[:order_id]
    if @invoice.save
      redirect_to edit_order_invoice_url(@invoice.order, @invoice)
    else
      ## error handling
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @order = @invoice.order
    @invoice_items = @invoice.invoice_items
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(invoice_params)

      redirect_to invoice_url(@invoice)
    else
      # error_handling
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:user_id, :order_id)
  end
end
