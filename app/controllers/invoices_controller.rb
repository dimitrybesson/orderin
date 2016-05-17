class InvoicesController < ApplicationController

  def index
    # this will have to be filterable for a supplier, restaurant
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to edit_invoice_url(@invoice)
    else
      ## what now?
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @order = @invoice.order
    @order_items = @order.order_items
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(invoice_params)
      reidrect_to invoice_url(@invoice)
    else
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:user_id, :order_id)
  end
end
