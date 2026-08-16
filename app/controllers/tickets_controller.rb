# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]

  def index
    @tickets = Ticket.order_by(created_at: :desc)
    @ticket = Ticket.new
  end

  def show; end

  def new
    @ticket = Ticket.new
  end

  def edit; end

  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to root_path, notice: "Ticket booked for #{@ticket.name}." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "ticket_form",
            partial: "tickets/form",
            locals: { ticket: @ticket }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to root_path, notice: "Ticket updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "ticket_form",
            partial: "tickets/form",
            locals: { ticket: @ticket }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Ticket voided. Poof!" }
      format.turbo_stream
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :seat_id_seq, :address, :price_paid, :email_address)
  end
end