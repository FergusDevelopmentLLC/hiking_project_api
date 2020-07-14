class Scraper

    def self.get_trails_from_api(latitude:, longitude:, max_distance:, max_results:)
        
      url = "https://www.hikingproject.com/data/get-trails?lat=#{latitude}&lon=#{longitude}&maxDistance=#{max_distance}&maxResults=#{max_results}&key=#{ENV['HIKINGPROJECT_API_KEY']}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      api_trails = JSON.parse(response)
            
      api_trails["trails"].map {|trail|

        {   
          :hiking_project_id => trail["id"],
          :name => trail["name"],
          :trail_type => trail["type"],
          :length => trail["length"],
          :summary => trail["summary"],
          :stars => trail["stars"],
          :starVotes => trail["starVotes"],
          :location => trail["location"],
          :imgSqSmall => trail["imgSqSmall"],
          :imgSmall => trail["imgSmall"],
          :imgSmallMed => trail["imgSmallMed"],
          :imgMedium => trail["imgMedium"],
          :difficulty => trail["difficulty"],
          :stars => trail["stars"],
          :ascent => trail["ascent"],
          :descent => trail["descent"],
          :high => trail["high"],
          :low => trail["low"],
          :longitude => trail["longitude"],
          :latitude => trail["latitude"],
          :url => trail["url"],
          :conditionStatus => trail["conditionStatus"],
          :conditionDetails => trail["conditionDetails"],
          :conditionDate => trail["conditionDate"]
        }   
      }
    end

    def self.scrape_trail_detail(trail_url)
      #returns a trail detail hash (features, overview, description)
      
      trail_details_hash = {}

      doc = Nokogiri::HTML(open(trail_url))
      
      #https://stackoverflow.com/questions/1474688/nokogiri-how-to-select-nodes-by-matching-text
      #https://stackoverflow.com/questions/5393593/how-do-i-get-the-next-html-element-in-nokogiri
      features_h3 = doc.at('h3:contains("Features")')
      if features_h3
          trail_details_hash[:features] = features_h3.search("span").text.strip
      end

      overview_h3 = doc.at('h3:contains("Overview")')
      if overview_h3
          trail_details_hash[:overview] = overview_h3.next_element.text.strip.gsub(/[\r\n]+/, "")
      end

      desc_h3 = doc.at('h3:contains("Description")')
      if desc_h3
          trail_details_hash[:description] = desc_h3.next_element.text.strip.gsub(/[\r\n]+/, "")
      end

      trail_details_hash
    end

end