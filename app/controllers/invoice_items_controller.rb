class InvoiceItemsController < ApplicationController

  def create
    @invoice_item = InvoiceItem.new(invoice_item_params)
  end

  def update
    @invoice_item = InvoiceItem.find(params[:id])

    #calculate delta here?
  end

  # mass_update

  def destroy
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice = @invoice_item.invoice
    @order = @invoice.order
    @order_items = @order.order_items
  end

  private
  def invoice_item_params
    params.require(:invoice_item).permit(:invoice_id, :order_item_id, :quantity)
  end

end
