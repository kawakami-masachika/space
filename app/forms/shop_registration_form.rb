class ShopRegistrationForm
  include ActiveModel::Model

  attr_accessor :shop_name,
                :open_time,
                :close_time,
                :tel_number,
                :site_url,
                :instgram_url,
                :shop_info,
                :sales_info,
                :user_id,
                :shop_style_ids

  def initialize(shop_params = {})
    @shop_name = shop_params[:shop_name]
    @open_time = shop_params[:open_time]
    @close_time = shop_params[:close_time]
    @tel_number = shop_params[:tel_number]
    @instgram_url = shop_params[:instgram_url]
    @site_url = shop_params[:site_url]
    @shop_info = shop_params[:shop_info]
    @sales_info = shop_params[:sales_info]
    @user_id = shop_params[:user_id]
    @shop_style_ids = shop_params[:shop_style_ids]
  end

  def save
    return false if invalid?
    shop.save!

    if ary_params?(shop_style_ids)
      shop_style(@shop.id)
    end

  end

  private
  def shop
    @shop = Shop.new( shop_name: shop_name,
                  open_time: open_time,
                  close_time: close_time,
                  tel_number: tel_number, 
                  site_url: site_url,
                  instgram_url: instgram_url,
                  shop_info: shop_info,
                  user_id: user_id
                )
  end

  def shop_style(shop_id)
    shop_style_list = []

    shop_style_ids.each do |style_id|
      style_params = {}
      style_params[:shop_id] = shop_id
      style_params[:style_id] = style_id
      shop_style_list << style_params
    end
    ShopStyle.create(shop_style_list)
  end

  # 配列のサイズチェック
  def ary_params?(pram_list)
    pram_list.present? ? true : false
  end
end