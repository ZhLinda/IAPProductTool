#!/usr/bin/ruby
# -*- coding: UTF-8 -*-

require 'roo'

module Devyuan

  class ExcelHelper

    def initialize(path)
      @path = path
      @xlsx = Roo::Spreadsheet.open(path, extension: :xlsx)
      @result = []
    end

    def parse()

      sheet = @xlsx.sheet(0)
      rows_count = sheet.last_row # 总行数
      colunms_count = sheet.last_column # 总列数
      titles = []

      rows_count.times do |r|

        # 将第一行的标题取出
        if r == 0
          colunms_count.times do |c|
            res = sheet.cell(r + 1, c + 1)
            titles << res
          end

          next
        end

        rows = {}

        colunms_count.times do |c|
          res = sheet.cell(r + 1, c + 1)
          rows[titles[c]] = res # 将标题作为 key ，将单元格的内容作为 value
        end

        @result << rows

      end

      @result
    end

  end

end