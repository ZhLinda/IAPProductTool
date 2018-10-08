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
            rows_count = sheet.last_row
            colunms_count = sheet.last_column
            titles = []

            rows_count.times do |r|

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
                    rows[titles[c]] = res
                end

                @result << rows

            end
            
            @result
        end

    end

end