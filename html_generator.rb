require 'json'
require 'open-uri'

class HtmlGenerator
	def index
		# total_response = open("http://lcboapi.com/products?per_page=100").read
		# parsed_total = JSON.parse(total_response)
		# total_pages = parsed_total["pager"]["final_page"].to_i
		@all_products = []
		num = 1
		 3.times do 
		    	num_string = num.to_s
		    	products_page = open("http://lcboapi.com/products?page=#{num}&per_page=100").read
		    	parsed_products = JSON.parse(products_page)["result"] #=> hash
		    	for i in 0..parsed_products.length-1
		    		@all_products << parsed_products[i] # => Array of hashes
		    	end
		    	num += 1
		 end
		html_doctype
		main_wrapper
		beers_html_doctype
		wines_html_doctype
		spirits_html_doctype
	end

	def beers
	 	@all_beers = []
	 	@all_products.each_with_index do |value, index| 
	 		if @all_products[index]["primary_category"] == "Beer"
	 			@all_beers << @all_products[index]
	 		end
	 	end
	 	lcbo_beers = File.open("lcbo_beers.html", "a")
	 	lcbo_beers.puts "\t<div class=\"page_container\">"

		 	lcbo_beers.puts "\t<div class=\"page_header\">" #<----HEADER
		 		lcbo_beers.puts "<div class=\"header_navigation\">"
		 			lcbo_beers.puts "<h1>LCBO BEERS</h1>"
		 		lcbo_beers.puts "\t</div>" #closing header_navigation
		 		lcbo_beers.puts "<div class=\"header_navigation\">"
			 		lcbo_beers.puts "<ul>"
			        	 lcbo_beers.puts "<li><a href=\"lcbo_spirits.html\">SPIRITS</a></li>"
			        	 lcbo_beers.puts "<li><a href=\"lcbo_wines.html\">WINE</a></li>"
			        	 lcbo_beers.puts "<li><a href=\"lcbo_beers.html\">BEERS</a></li>"
			        	 lcbo_beers.puts "<li><a href=\"lcbo.html\">HOME</a></li>"
					lcbo_beers.puts "</ul>"
					lcbo_beers.puts "\t</div>" #closing header_navigation
			 lcbo_beers.puts "\t</div>" #<------CLOSING HEADER

		 	lcbo_beers.puts "\t<div class=\"page_body\">" #<-----BODY
		 			@all_beers.each_with_index do |beer, index|
		 				lcbo_beers.puts "\t\t<div class=\"product_details\">"
		 					lcbo_beers.puts "<div class=\"item_info\">"
		 						if @all_beers[index]["image_thumb_url"] == nil
		 							lcbo_beers.puts "<img src=img/beer_image.jpg>"
		 						else
		 							lcbo_beers.puts "<img src=\"#{@all_beers[index]["image_thumb_url"]}\">"
		 						end
		 					lcbo_beers.puts "</div>" #closing item_info(image)
		 					lcbo_beers.puts "<div class=\"item_info\">"
		 						lcbo_beers.puts "<h3>#{@all_beers[index]["name"]}</h3>"
		 						lcbo_beers.puts "<p><span class=\"category\">Price:</span> $#{(@all_beers[index]["regular_price_in_cents"].to_f)/100}</p>"
		 						lcbo_beers.puts "<p><span class=\"category\">Origin:</span> #{@all_beers[index]["origin"]}"
		 						lcbo_beers.puts "<p><span class=\"category\">Alcohol Content:</span> #{(@all_beers[index]["alcohol_content"].to_f)/100}%</p>"
		 						lcbo_beers.puts "<p><span class=\"category\">Package:</span> #{@all_beers[index]["package"]}"
		 					lcbo_beers.puts "</div>" #closing item_info(details)
		 				lcbo_beers.puts "\t\t\</div>" #closing list_items div
		 			end
		 	lcbo_beers.puts "\t</div>" #<--------CLOSING PAGE BODY

			lcbo_beers.puts "\t<div class=\"page_footer\">" #<-----FOOTER
		 		lcbo_beers.puts "\t\t<h1>CHEERS!</h1>"
		 	lcbo_beers.puts "\t</div>" #closing page_body div
	 	lcbo_beers.puts "</div>" #closing page_container div
	 	lcbo_beers.puts "</body"
	 	lcbo_beers.puts "</html>"
	 	lcbo_beers.close 
	 end

	 def wines
	 	@all_wines = []
	 	@all_products.each_with_index do |value, index| 
	 		if @all_products[index]["primary_category"] == "Wine"
	 			@all_wines << @all_products[index]
	 		end
	 	end
	 	lcbo_wines = File.open("lcbo_wines.html", "a")
	 	lcbo_wines.puts "\t<div class=\"page_container\">"

		 	lcbo_wines.puts "\t<div class=\"page_header\">" #<----HEADER
		 		lcbo_wines.puts "<div class=\"header_navigation\">"
		 			lcbo_wines.puts "<h1>LCBO WINES</h1>"
		 		lcbo_wines.puts "\t</div>" #closing header_navigation
		 		lcbo_wines.puts "<div class=\"header_navigation\">"
			 		lcbo_wines.puts "<ul>"
			        	 lcbo_wines.puts "<li><a href=\"lcbo_spirits.html\">SPIRITS</a></li>"
			        	 lcbo_wines.puts "<li><a href=\"lcbo_wines.html\">WINE</a></li>"
			        	 lcbo_wines.puts "<li><a href=\"lcbo_beers.html\">BEERS</a></li>"
			        	 lcbo_wines.puts "<li><a href=\"lcbo.html\">HOME</a></li>"
					lcbo_wines.puts "</ul>"
					lcbo_wines.puts "\t</div>" #closing header_navigation
			lcbo_wines.puts "\t</div>" #<------CLOSING HEADER

		 	lcbo_wines.puts "\t<div class=\"page_body\">" #<-----BODY
		 			@all_wines.each_with_index do |wine, index|
		 				lcbo_wines.puts "\t\t<div class=\"product_details\">"
		 					lcbo_wines.puts "<div class=\"item_info\">"
		 						if @all_wines[index]["image_thumb_url"] == nil
		 							lcbo_wines.puts "<img src=img/wine_image.jpg>"
		 						else
		 							lcbo_wines.puts "<img src=\"#{@all_wines[index]["image_thumb_url"]}\">"
		 						end
		 					lcbo_wines.puts "</div>" #closing item_info(image)
		 					lcbo_wines.puts "<div class=\"item_info\">"
		 						lcbo_wines.puts "<h3>#{@all_wines[index]["name"]}</h3>"
		 						lcbo_wines.puts "<p><span class=\"category\">Price:</span> $#{(@all_wines[index]["regular_price_in_cents"].to_f)/100}</p>"
		 						lcbo_wines.puts "<p><span class=\"category\">Origin:</span> #{@all_wines[index]["origin"]}"
		 						lcbo_wines.puts "<p><span class=\"category\">Alcohol Content:</span> #{(@all_wines[index]["alcohol_content"].to_f)/100}%</p>"
		 						lcbo_wines.puts "<p><span class=\"category\">Red or White:</span> #{@all_wines[index]["secondary_category"]}"
		 					lcbo_wines.puts "</div>" #closing item_info(details)
		 				lcbo_wines.puts "\t\t\</div>" #closing list_items div
		 			end
		 	lcbo_wines.puts "\t</div>" #<--------CLOSING PAGE BODY

			lcbo_wines.puts "\t<div class=\"page_footer\">" #<-----FOOTER
		 		lcbo_wines.puts "\t\t<h1>CHEERS!</h1>"
		 	lcbo_wines.puts "\t</div>" #closing page_body div
	 	lcbo_wines.puts "</div>" #closing page_container div
	 	lcbo_wines.puts "</body"
	 	lcbo_wines.puts "</html>"
	 	lcbo_wines.close
	 end

	 def spirits
	 	@all_spirits = []
	 	@all_products.each_with_index do |value, index| 
	 		if @all_products[index]["primary_category"] == "Spirits"
	 			@all_spirits << @all_products[index]
	 		end
	 	end
	 	lcbo_spirits = File.open("lcbo_spirits.html", "a")
	 	lcbo_spirits.puts "\t<div class=\"page_container\">"

		 	lcbo_spirits.puts "\t<div class=\"page_header\">" #<----HEADER
		 		lcbo_spirits.puts "<div class=\"header_navigation\">"
		 			lcbo_spirits.puts "<h1>LCBO SPIRITS</h1>"
		 		lcbo_spirits.puts "\t</div>" #closing header_navigation
		 		lcbo_spirits.puts "<div class=\"header_navigation\">"
			 		lcbo_spirits.puts "<ul>"
			        	 lcbo_spirits.puts "<li><a href=\"lcbo_spirits.html\">SPIRITS</a></li>"
			        	 lcbo_spirits.puts "<li><a href=\"lcbo_wines.html\">WINE</a></li>"
			        	 lcbo_spirits.puts "<li><a href=\"lcbo_beers.html\">BEERS</a></li>"
			        	 lcbo_spirits.puts "<li><a href=\"lcbo.html\">HOME</a></li>"
					lcbo_spirits.puts "</ul>"
					lcbo_spirits.puts "\t</div>" #closing header_navigation
			 lcbo_spirits.puts "\t</div>" #<------CLOSING HEADER

		 	lcbo_spirits.puts "\t<div class=\"page_body\">" #<-----BODY
		 			@all_spirits.each_with_index do |spirit, index|
		 				lcbo_spirits.puts "\t\t<div class=\"product_details\">"
		 					lcbo_spirits.puts "<div class=\"item_info\">"
		 						if @all_spirits[index]["image_thumb_url"] == nil
		 							lcbo_spirits.puts "<img src=img/spirit_image.jpg>"
		 						else
		 							lcbo_spirits.puts "<img src=\"#{@all_spirits[index]["image_thumb_url"]}\">"
		 						end
		 					lcbo_spirits.puts "</div>" #closing item_info(image)
		 					lcbo_spirits.puts "<div class=\"item_info\">"
		 						lcbo_spirits.puts "<h3>#{@all_spirits[index]["name"]}</h3>"
		 						lcbo_spirits.puts "<p><span class=\"category\">Price:</span> $#{(@all_spirits[index]["regular_price_in_cents"].to_f)/100}</p>"
		 						lcbo_spirits.puts "<p><span class=\"category\">Origin:</span> #{@all_spirits[index]["origin"]}"
		 						lcbo_spirits.puts "<p><span class=\"category\">Alcohol Content:</span> #{(@all_spirits[index]["alcohol_content"].to_f)/100}%</p>"
		 						lcbo_spirits.puts "<p><span class=\"category\">Type:</span> #{@all_spirits[index]["secondary_category"]}"
		 					lcbo_spirits.puts "</div>" #closing item_info(details)
		 				lcbo_spirits.puts "\t\t\</div>" #closing list_items div
		 			end
		 	lcbo_spirits.puts "\t</div>" #<--------CLOSING PAGE BODY

			lcbo_spirits.puts "\t<div class=\"page_footer\">" #<-----FOOTER
		 		lcbo_spirits.puts "\t\t<h1>CHEERS!</h1>"
		 	lcbo_spirits.puts "\t</div>" #closing page_body div
	 	lcbo_spirits.puts "</div>" #closing page_container div
	 	lcbo_spirits.puts "</body"
	 	lcbo_spirits.puts "</html>"
	 	lcbo_spirits.close 
	 end

	 def beers_html_doctype
	 	lcbo_beers = File.open("lcbo_beers.html", "w")
	 	lcbo_beers.puts "<!DOCTYPE html>"
	 	lcbo_beers.puts "<html lang=\"en\">"
	 	lcbo_beers.puts "<head>"
	 	lcbo_beers.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"reset.css\">"
	 	lcbo_beers.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
	 	lcbo_beers.puts "\t<link href=\'http://fonts.googleapis.com/css?family=Istok+Web:400,700\' rel=\'stylesheet\' type=\'text/css\'>"
	 	lcbo_beers.puts "\t<title>LCBO Beers</title>"
	 	lcbo_beers.puts "</head>"
	 	lcbo_beers.puts ""
	 	lcbo_beers.puts "<body>"
	 	lcbo_beers.close
	 	beers
	 end

	 def wines_html_doctype
	 	lcbo_wines = File.open("lcbo_wines.html", "w")
	 	lcbo_wines.puts "<!DOCTYPE html>"
	 	lcbo_wines.puts "<html lang=\"en\">"
	 	lcbo_wines.puts "<head>"
	 	lcbo_wines.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"reset.css\">"
	 	lcbo_wines.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
	 	lcbo_wines.puts "\t<link href=\'http://fonts.googleapis.com/css?family=Istok+Web:400,700\' rel=\'stylesheet\' type=\'text/css\'>"
	 	lcbo_wines.puts "\t<title>LCBO Wines</title>"
	 	lcbo_wines.puts "</head>"
	 	lcbo_wines.puts ""
	 	lcbo_wines.puts "<body>"
	 	lcbo_wines.close
	 	wines
	 end

	 def spirits_html_doctype
	 	lcbo_spirits = File.open("lcbo_spirits.html", "w")
	 	lcbo_spirits.puts "<!DOCTYPE html>"
	 	lcbo_spirits.puts "<html lang=\"en\">"
	 	lcbo_spirits.puts "<head>"
	 	lcbo_spirits.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"reset.css\">"
	 	lcbo_spirits.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
	 	lcbo_spirits.puts "\t<link href=\'http://fonts.googleapis.com/css?family=Istok+Web:400,700\' rel=\'stylesheet\' type=\'text/css\'>"
	 	lcbo_spirits.puts "\t<title>LCBO Spirits</title>"
	 	lcbo_spirits.puts "</head>"
	 	lcbo_spirits.puts ""
	 	lcbo_spirits.puts "<body>"
	 	lcbo_spirits.close
	 	spirits
	 end

	def html_doctype
	 	puts "<!DOCTYPE html>"
	 	puts "<html lang=\"en\">"
	 	puts "<head>"
	 	puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"reset.css\">"
	 	puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
	 	puts "\t<link href=\'http://fonts.googleapis.com/css?family=Istok+Web:400,700\' rel=\'stylesheet\' type=\'text/css\'>"
	 	puts "\t<title>LCBO Products</title>"
	 	puts "</head>"
	 	puts ""
	 	puts "<body>"
	 end


	def main_wrapper
	 	puts "<div id=\"main_container\">"
	 		puts "<div id=\"main_image\">"
	 			puts "<img src=img/lcbo_logo.png>"
	 		puts "</div>"
	 		puts "<div id=\"main_navigation\">"
	 		puts "<ul>"
	 			puts "<li><a href=\"lcbo_beers.html\">BEERS</a></li>"
	 			puts "<li><a href=\"lcbo_wines.html\">WINE</a></li>"
	 			puts "<li><a href=\"lcbo_spirits.html\">SPIRITS</a></li>"
			        
			puts "</ul>"
	 		puts "</div>"
	 	puts "</div>" #<-----CLOSE OF MAIN CONTAINER
	 	puts "</body>"
	 	puts "</html>"
	end


	def show(product_id)
		product = []
    	products_page = open("http://lcboapi.com/products/#{product_id}").read
    	parsed_product = JSON.parse(products_page)["result"] #=> hash
    	product << parsed_product # => Array of hashes
    	html_doctype
    	product_page_html
	end

	def product_page_html
		puts "\t<div class=\"page_container\">"
			puts "\t<div class=\"page_header\">" #<----HEADER
			 	puts "<div class=\"header_navigation\">"
			 		puts "<h1>LCBO PRODUCT</h1>"
			 	puts "\t</div>" #closing header_navigation
			 		puts "<div class=\"header_navigation\">"
				 		puts "<ul>"
				        	 puts "<li><a href=\"lcbo_spirits.html\">SPIRITS</a></li>"
				        	 puts "<li><a href=\"lcbo_wines.html\">WINE</a></li>"
				        	 puts "<li><a href=\"lcbo_beers.html\">BEERS</a></li>"
				        	 puts "<li><a href=\"lcbo.html\">HOME</a></li>"
						puts "</ul>"
						puts "\t</div>" #closing header_navigation
				 puts "\t</div>" #<------CLOSING HEADER
		puts "</div>" #<--------CLOSING PAGE CONTAINER
	end
end