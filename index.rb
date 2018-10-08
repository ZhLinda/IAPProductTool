#!/usr/bin/ruby
# -*- coding: UTF-8 -*-

require './excel_helper'
require './iap_helper'
require 'json'

usage = "usage: ruby index.rb arg0 arg1
        arg0: your app folder
        arg1: <create|modify>
        "

abort("#arg0 empty \n#{usage}") unless ARGV[0]
abort("#arg1 empty \n#{usage}") unless ARGV[1]

app = ARGV[0]
opt = ARGV[1]

base_path = './'
res_path = File::join(base_path, 'res')

app_path = File::join(res_path, app)
abort("#app_path=#{app_path} not exist !") unless File.exist?(app_path)

excel_path = File::join(app_path, 'product.xlsx')
abort("#excel_path=#{excel_path} not exist!") unless File::exist?(excel_path)

excle_helper = Devyuan::ExcelHelper.new(excel_path)
products = excle_helper.parse

config_path = File::join(app_path, 'config.json')
abort("#config_path=#{config_path} not exist") unless File::exist?(config_path)

config = File::read(config_path)

configs = JSON.parse(config)
abort("configs=#{configs} empty") unless configs

iap_helper = Devyuan::IAPHelper.new(app_path, configs['account'], configs['bundle_id'], products)

iap_helper.create if opt == 'create'
iap_helper.modify if opt == 'modify'


