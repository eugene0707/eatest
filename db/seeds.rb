seeds_file = File.join(Rails.root, 'db', 'seeds.yml')
seeds_data = YAML::load_file(seeds_file)

seeds_data['skills'].each{ |skill| Skill.find_or_create_by(name: skill.last['name']) } if seeds_data['skills']

seeds_data['vacancies'].each do |vacancy|
  vacancy = vacancy.last
  Vacancy.find_or_create_by(name: vacancy['name']) do |new_vacancy|
    new_vacancy.available_to=vacancy['available_to'].to_i.days.from_now
    new_vacancy.salary=vacancy['salary'].to_i
    new_vacancy.email=vacancy['email']
    new_vacancy.phone=vacancy['phone']
    new_vacancy.skill_ids=vacancy['skill_ids'].to_a
  end
end if seeds_data['vacancies']

seeds_data['applicants'].each do |applicant|
  applicant = applicant.last
  Applicant.find_or_create_by(name: applicant['name']) do |new_applicant|
    new_applicant.is_active=applicant['is_active'].to_i
    new_applicant.salary=applicant['salary'].to_i
    new_applicant.email=applicant['email']
    new_applicant.phone=applicant['phone']
    new_applicant.skill_ids=applicant['skill_ids'].to_a
  end
end if seeds_data['applicants']
