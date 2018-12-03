#!/usr/bin/ruby
# -*- coding: UTF-8 -*-

require 'spaceship'

module Devyuan

  class IAPHelper

    def initialize(path, account, bundle_id, products)
      @path = path
      @account = account
      @bundle_id = bundle_id
      @products = products
      Spaceship::Tunes.login(account) # 登录 itunesconnect
      @app = Spaceship::Application.find(bundle_id)
    end

    def create()
      type = Spaceship::Tunes::IAPType::CONSUMABLE

      @products.each do |product|

        status = product['status']
        next if status == 0

        tier = get_tier(product['amount']) # 获取商品价格等级

        product_id = "#{@bundle_id}.#{product['id']}"

        review_image_path = File::join(@path, "#{product['review_image']}.jpg")
        abort("#review_image=#{review_image_path} not exist") unless File::exist?(review_image_path)

        puts "#uploading ... product=#{product}"

        begin
          @app.in_app_purchases.create!( # 创建商品
            type: type,
            versions: {
              'zh-CN': {
                name: product['name'],
                description: product['desc']
              }
            },
            reference_name: product['name'],
            product_id: product_id,
            cleared_for_sale: true,
            review_notes: product['review_desc'],
            review_screenshot: review_image_path,
            pricing_intervals: [
              {
                country: "WW",
                begin_date: nil,
                end_date: nil,
                tier: tier
              }
            ]
          )
          puts "#upload success"
        rescue Exception => error
          puts "#upload failure, error=#{error}"
        end
      end
    end

    def modify()
      @products.each do |product|

        status = product['status']
        next if status == 0

        product_id = "#{@bundle_id}.#{product['id']}"

        tier = get_tier(product['amount'])

        review_image_path = File::join(@path, "#{product['review_image']}.jpg")
        abort("#review_image=#{review_image_path} not exist") unless File::exist?(review_image_path)

        puts "#modify ... product=#{product}"

        begin
          purch = @app.in_app_purchases.find(product_id) # 查找商品
          e = purch.edit # 编辑商品
          e.versions = {
            'zh-CN': {
              name: product['name'],
              description: product['desc']
            }
          }
          e.reference_name = product['name']
          e.review_notes = product['review_desc']
          e.review_screenshot = review_image_path
          e.pricing_intervals = [
            {
              country: "WW",
              begin_date: nil,
              end_date: nil,
              tier: tier
            }
          ]
          e.save!

          puts "#modify success"
        rescue Exception => error
          puts "#modify failure, error=#{error}"
        end
      end
    end

    def get_tier(amount)
      tier = {
        6 => 1,
        30 => 5,
        50 => 8,
        88 => 13,
        98 => 15,
        128 => 20,
        188 => 28,
        198 => 30,
        228 => 34,
        288 => 46,
        328 => 50,
        548 => 57,
        648 => 60
      }
      abort("#tier not exist when amount=#{amount}") unless tier[amount]
      tier[amount]
    end
  end
end