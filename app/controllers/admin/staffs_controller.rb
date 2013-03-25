class Admin::StaffsController < Admin::AdminBaseController
  before_filter :admin_access
    def new
      @staff = Staff.new
    end
    def create
      @staff = Staff.new(params[:staff])
      if @staff.save
        flash[:success] = "Successfully added member of staff"
        redirect_to admin_staffs_path
      else
        render :action => 'new'
      end
    end

    def index
      @staffs = Staff.order(sort_column(Staff) + " " + sort_direction)
    end

    def edit
      @staff = Staff.find(params[:id])
    end

    def update
      @staff = Staff.find(params[:id])
      if @staff.update_attributes(params[:staff])
        flash[:success] = "Staff information updated"
        redirect_to admin_staffs_path
      else
        render :action => 'edit'
      end
    end
    def destroy
      Staff.find(params[:id]).destroy
      redirect_to admin_staffs_path
    end
end
 
