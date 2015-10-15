json.partial! 'applicant', applicant: applicant
json.skills(applicant.skills) do |skill|
  json.partial! 'skill', skill: skill
end
json.strict_vacancies(applicant.strict_vacancies) do |vacancy|
  json.partial! 'vacancy', vacancy: vacancy
end
json.partial_vacancies(applicant.partial_vacancies) do |vacancy|
  json.partial! 'vacancy', vacancy: vacancy
end
