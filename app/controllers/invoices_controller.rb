class InvoicesController < ApplicationController

  def index
    # this will have to be filterable for a supplier, restaurant
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
      ## what now?
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
