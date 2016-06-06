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

  def mass_update
    @invoice = Invoice.find(params[:invoice])
    @invoice_items = @invoice.invoice_items
    @order = @invoice.order
    @invoice_items.each do |invoice_item|
      # maybe refactor this at some point
      item_quantity = params["#{invoice_item.id}"].to_i
      item_quantity = 0 if item_quantity.nil?
      delta = invoice_item.quantity - item_quantity
      invoice_item.update_inventory(delta)
      invoice_item.update_attribute("quantity", (invoice_item_mass_params("#{invoice_item.id}")["#{invoice_item.id}"]).to_i)
    end
    @order.status[:invoiced] = true
    @order.save
    redirect_to order_invoice_url(@order, @invoice)
  end

  private
  def invoice_item_params
    params.require(:invoice_item).permit(:invoice_id, :order_item_id, :quantity)
  end

  def invoice_item_mass_params(invoice_item_id)
    params.permit(invoice_item_id)
  end

end
