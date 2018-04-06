require 'httparty'

ShopifyHeaders = { 
	  "Authorization"  => "Basic YWIyNjhkNzUxN2E3NTA2MjY4MWFhNmU5Y2FmMTBmN2U6NmQyNzE2MWI2M2U0NGI4NGJlZThmODEzMmQwOGFmOWE=", 
}

def get_all_products

	@parsed_products_array = []
	
	shopify_products = HTTParty.get("https://roquetest.myshopify.com/admin/products.json", :headers => ShopifyHeaders).parsed_response

	shopify_products['products'].each do |product|
		title 		= product['title']
		price 		= product['variants'][0]['price']
		img 		= product['images'][0]['src']
		product_id 	= product['variants'][0]['product_id']

		shop 		= "Shopify"

		@parsed_products_array << ParsedProduct.new(product_id, title, price, img, shop)
	end

	return @parsed_products_array
end

def get_product(product_id)
	
	shopify_products = HTTParty.get("https://roquetest.myshopify.com/admin/products/"+product_id+".json", :headers => ShopifyHeaders).parsed_response
	@parsed_product		
	
	title 		= shopify_products['product']['title']
	price 		= shopify_products['product']['variants'][0]['price']
	img 		= shopify_products['product']['images'][0]['src']
	product_id 	= shopify_products['product']['variants'][0]['product_id']
	variants = shopify_products['product']['variants']
	shop 		= "Shopify"

	@parsed_product = ParsedProduct.new(product_id, title, variants, price, img, shop)
	return @parsed_product
end

def delete_product

	@parsed_products_array = []

	shopify_products = HTTParty.get("https://roquetest.myshopify.com/admin/products.json", :headers => ShopifyHeaders).parsed_response

	shopify_products['products'].each do |product|
		title 		= product['title']
		price 		= product['variants'][0]['price']
		img 		= product['images'][0]['src']
		product_id 	= product['variants'][0]['product_id']
		shop 		= "Shopify"

		@parsed_products_array << ParsedProduct.new(title, price, img, shop)
	end

	return @parsed_products_array
end

def add_product

	@parsed_products_array = []

	shopify_products = HTTParty.get("https://roquetest.myshopify.com/admin/products.json", :headers => ShopifyHeaders).parsed_response

	shopify_products['products'].each do |product|
		title 		= product['title']
		price 		= product['variants'][0]['price']
		img 		= product['images'][0]['src']
		product_id 	= product['variants'][0]['product_id']
		shop 		= "Shopify"

		@parsed_products_array << ParsedProduct.new(title, price, img, shop)
	end

	return @parsed_products_array
end

def update_product(product_id, new_title, variant_id, price)
	body = {
  "product": {
    "id": product_id,
    "title": new_title,
    "variants": [
      {
        "id": variant_id,
        "price": price
      }
  	]
  }
}
	shopify_products = HTTParty.put("https://roquetest.myshopify.com/admin/products/"+product_id+".json", :body => body, :headers => ShopifyHeaders).parsed_response
end

class ParsedProduct
  def initialize(product_id, title, variants=[], price, img, shop)
    
  	@variants = variants
    @product_id = product_id
    @title 	= title
    @price 	= price
    @img 	= img
    @shop 	= shop
  end

  def variants
    @variants
  end

  def product_id
    @product_id
  end

  def title
    @title
  end

  def price
    @price
  end

  def img
    @img
  end

  def shop
    @shop
  end

end

class ProductsController < ApplicationController
	def index
		@response = get_all_products
	end

	def edit
		@parsed_product = get_product(params[:id])

	end

	def update
		update_product(params[:id],params[:title], params[:variant_id], params[:price])
	end

	def delete
		@product_id = params[:id]
	end

	def new
		
	end


end
