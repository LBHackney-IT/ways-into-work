module WordpressApi

    @@auth = {
        username: ENV["WORDPRESS_USER"],
        password: ENV["WORDPRESS_PASSWORD"]
    }

    def get_intakes(ids)
        response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake?status=publish&per_page=100&include=#{ids.uniq.join(",")}", {
            basic_auth: @@auth
        })
        response.parsed_response
    end

    def get_vacancies(ids)
        response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy?status=publish&per_page=100&include=#{ids.uniq.join(",")}", {
            basic_auth: @@auth
        })
        response.parsed_response
    end

    def get_object_by_id(type, id)
        if type == "CourseApplication"
            response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake/#{id}", {
                basic_auth: @@auth
            })
        elsif type == "VacancyApplication"
            response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy/#{id}", {
                basic_auth: @@auth
            })
        end
        response.parsed_response
    end

end