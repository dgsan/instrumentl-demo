class TaxEntitiesController < ApplicationController
  before_action :set_tax_entity, only: %i[ show edit update destroy ]

  # GET /tax_entities or /tax_entities.json
  def index
    if params[:state]
      state = params.permit(:state)
      @tax_entities = TaxEntity.grants.includes(granted: :to).references(:to).where(to: {state: state[:state].upcase })
    else
      @tax_entities = TaxEntity.grants.includes(granted: :to)
    end
    options = {
      include: [:granted, :'granted.to']
    }
    respond_to do |format|
      format.json { render json: TaxEntitySerializer.new(@tax_entities, options).serializable_hash.to_json }
      format.html { render "static/index" }
    end
  end

  # GET /tax_entities/1 or /tax_entities/1.json
  def show
  end

  # GET /tax_entities/new
  def new
    @tax_entity = TaxEntity.new
  end

  # GET /tax_entities/1/edit
  def edit
  end

  # POST /tax_entities or /tax_entities.json
  def create
    @tax_entity = TaxEntity.new(tax_entity_params)

    respond_to do |format|
      if @tax_entity.save
        format.html { redirect_to @tax_entity, notice: "Tax entity was successfully created." }
        format.json { render :show, status: :created, location: @tax_entity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tax_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tax_entities/1 or /tax_entities/1.json
  def update
    respond_to do |format|
      if @tax_entity.update(tax_entity_params)
        format.html { redirect_to @tax_entity, notice: "Tax entity was successfully updated." }
        format.json { render :show, status: :ok, location: @tax_entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tax_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tax_entities/1 or /tax_entities/1.json
  def destroy
    @tax_entity.destroy
    respond_to do |format|
      format.html { redirect_to tax_entities_url, notice: "Tax entity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_entity
      @tax_entity = TaxEntity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tax_entity_params
      params.require(:tax_entity).permit(:ein, :name, :address, :city, :state, :post_code)
    end
end
