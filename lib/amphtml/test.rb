module Amphtml
    class Test

        def self.all
        end

        def self.markup
        end

        def self.html
        end

        def self.css
            # Rails.root.join('app', 'views')
            strings = ["@import", "!important", "-amp-", "i-amp-"]
            results = search_file_for(Dir.pwd, strings)
            if results.present?
                results.each do |source, string|
                    case string
                    when "@import"
                        warn "ERROR (AMP): CSS cannot contain `@import`"
                        puts source
                    when "!important"
                        warn "ERROR (AMP): Usage of the `!important` qualifier is not allowed"
                        puts source
                    when "-amp-"
                        warn "ERROR (AMP): `-amp-` is reserved for internal use by the AMP runtime"
                        puts source
                    when "i-amp-"
                        warn "ERROR (AMP): `i-amp-` is reserved for internal use by the AMP runtime"
                        puts source
                    end
                end
            else
                puts "AMP-HTML TEST: CSS tests executed without exceptions"
            end
        end

        # private

        def self.search_file_for(dir, strings)
            results = {}

            Dir.foreach(dir) do |file|
                next if file == '.' or file == '..'
                # puts file
                if File.file?(file)
                    line_number = 0
                    IO.foreach(file) do |line|
                        line_number = line_number + 1
                        if strings.any? { |string| line.include?(string) }
                            string = strings.detect { |string| line.include?(string) }
                            source = file + ":" + line_number.to_s
                            results[source] = string
                        end
                    end
                else
                    # search_file_for(file, strings)
                end
            end

            if results.present?
                return results
            else
                return nil
            end
        end

    end
end
