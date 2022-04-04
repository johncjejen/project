class ReadExcelController < ApplicationController

	def post_import

		project_id = params[:project_id]
		@project_id = project_id
		#@user = User.find(39)
		#proj_unit_id = 75
		proj_unit_id = params[:proj_unit_id]
		shoot_date = params[:shoot_date] 
		file = params[:file]
		name_file = file.original_filename;
		name_file = name_file.split('.xlsx')
		folder = "#{Rails.root}/public"
		concat = rand(12254)
		valor = concat.to_s
		namefile = name_file[0].to_s+'_'+valor+'.xlsx'
		#Ruta del archivo
		path = File.join(folder, namefile);
		resultado = File.open(path, "wb") { |f| f.write(file.read) };

		require 'spreadsheet'
		open_book = Roo::Spreadsheet.open(path)
		sheet = open_book.sheet(0)
		
		sheet.each_with_index do |sh, idx|
			if !sh[0].blank?
				read_text  = 1 if sh[0].to_s.include? 'CATERING' 
				read_text  = 2 if sh[0].to_s.include? 'Episodio' 
				read_text  = 3 if sh[0].to_s.include? 'CAST' 
				read_text  = 5 if sh[0].to_s.include? 'STUNTS' 
				read_text  = 6 if sh[0].to_s.include? 'EXTRAS' 
				read_text  = 7 if sh[0].to_s.include? 'NOTAS' 


				case read_text
				when 1
					read_food(sh)
					read_location(sh)
				when 2
					read_scenes(sh)
				when 3
					read_cast(sh,nil)
				when 4
					read_cast(sh,10)
				when 5
					read_cast(sh,15)
				when 6
					read_extra(sh)
				when 7
					read_notes(sh)
				end
			end
		end
		####################
		render :json => {
						:shooting_id => @shooting.id,
					}
		FileUtils.rm path
		
	end
	private
end
