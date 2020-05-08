require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_names
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  x = 0
  names = Array.new
  all_names = page.css(".lientxt").each do |n|
    names[x] = n.text
    x += 1
  end
  return names
end

def all_links

  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  x = 0
  lien = Array.new
  url = page.css(".lientxt").each do |link|
    lien[x] = "http://annuaire-des-mairies.com" + link['href'][1..-1]
    x += 1
  end
  return lien
end

def get_all_the_mails_of_val_doise_townhalls(links)
  x = 0
  my_mails = Array.new
  while links[x]
    pages = Nokogiri::HTML(open(links[x]))
    mails = pages.css("tr")
    my_mails[x] = mails.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    #puts my_mails[x]
    x+=1
  end
  return my_mails
end

def create_hash(name, mail)
  x = 0
  hash_mails = Hash.new
  while name[x]
    hash_mails[x] = {
      "Nom" => name[x],
      "Mail" => mail[x]
    }
    x += 1
  end
  x = 0
  while name[x]
    puts hash_mails[x]["Nom"]
    puts "#{hash_mails[x]["Mail"]} \n\n"
    x += 1
  end
end




puts "Choisissez en tapant le numéro associé:"
puts "1 - Obtenir le nom des villes du Val d'Oise"
puts "2 - Obtenir les liens des mairies du Val d'Oise"
puts "3 - Obtenir les mails de toutes les mairies du Val d'Oise"
puts "4 - Obtenir les informations triées"
puts "0 - Quitter"

menu = gets.chomp

case menu
when "1"
  puts "Patientez quelques instants le temps de charger..."
  names = get_names
  puts names
when "2"
  puts "Patientez quelques instants le temps de charger..."
  links = all_links
  puts links
when "3"
  puts "Patientez quelques instants le temps de charger..."
  links = all_links
  mails = get_all_the_mails_of_val_doise_townhalls(links)
  puts mails
when "4"
  puts "Patientez quelques instants le temps de charger..."
  names = get_names
  links = all_links()
  mails = get_all_the_mails_of_val_doise_townhalls(links)
  create_hash(names, mails)
else
  puts "Au revoir !"
  sleep(1)
end




=begin
names = get_names
links = all_links()
mails = get_all_the_mails_of_val_doise_townhalls(links)
create_hash(names, mails)
=end
