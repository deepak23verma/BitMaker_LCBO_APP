require 'json'
require 'open-uri'

class HtmlGenerator
	def index
		# total_response = open("http://lcboapi.com/products?per_page=100").read
		# parsed_total = JSON.parse(total_response)
		# total_pages = parsed_total["pager"]["final_page"].to_i
		@all_products = []
		num = 1
		 1.times do 
		    	num_string = num.to_s
		    	products_page = open("http://lcboapi.com/products?page=#{num}&per_page=100").read
		    	parsed_products = JSON.parse(products_page)["result"] #=> hash
		    	for i in 0..parsed_products.length-1
		    		@all_products << parsed_products[i] # => Array of hashesclea
		    	end
		    	num += 1
		 end
		html_doctype
		beers_html_doctype
	end

	def beers
	 	@all_beers = @all_products.each {|category, value| category == "primary_category" && value == "Beer"}
	 	lcbo_beers = File.open("lcbo_beers.html", "a")
	 	lcbo_beers.puts "\t<div class=\"page_container\">"
		 	lcbo_beers.puts "\t<div class=\"page_header\">"
		 		lcbo_beers.puts "\t\t<h1>Page Header</h1>"
		 	lcbo_beers.puts "\t<div>" #closing page_header div
		 	lcbo_beers.puts "\t<div class=\"page_body\">"
		 		lcbo_beers.puts "\t\t<h1>Page body</h1>"
		 	lcbo_beers.puts "\t<div>" #closing page_body div
		 	# @all_beers.each_with_index do |beer, index|
		 	# 	lcbo_beers.puts "\t\t<div class=\"product_details\">"
			# 		lcbo_beers.puts "\t\t\t<img src=\"#{@all_products[index]["image_thumb_url"]}\">"
			# 		lcbo_beers.puts "\t\t\t<h2>#{@all_beers[index]["name"]}</h2>"
		 	# 	lcbo_beers.puts "\t\t\</div>" #closing list_items div
		 	# end
	 	lcbo_beers.puts "</div>" #closing page_container div
	 	lcbo_beers.puts "</body"
	 	lcbo_beers.puts "</html>"
	 	lcbo_beers.close 
	 end

	 def beers_html_doctype
	 	lcbo_beers = File.open("lcbo_beers.html", "w")
	 	lcbo_beers.puts "<!DOCTYPE html>"
	 	lcbo_beers.puts "<html lang=\"en\">"
	 	lcbo_beers.puts "<head>"
	 	lcbo_beers.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"reset.css\">"
	 	lcbo_beers.puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
	 	lcbo_beers.puts "\t<title>LCBO Beers</title>"
	 	lcbo_beers.puts "</head>"
	 	lcbo_beers.puts ""
	 	lcbo_beers.puts "<body>"
	 	lcbo_beers.close
	 	beers
	 end

	def html_doctype
	 	puts "<!DOCTYPE html>"
	 	puts "<html lang=\"en\">"
	 	puts "<head>"
	 	puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"reset.css\">"
	 	puts "\t<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
	 	puts "\t<title>LCBO Products</title>"
	 	puts "</head>"
	 	puts ""
	 	puts "<body>"
	 	main_wrapper
	 end

	def main_wrapper
	 	puts "\t<div id=\"main_container\">"
	end


	# def show(product_id)
	# end
end