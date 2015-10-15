json.partial! 'vacancy', vacancy: vacancy
json.skills(vacancy.skills) do |skill|
  json.partial! 'skill', skill: skill
end
json.strict_applicants(vacancy.strict_applicants) do |applicant|
  json.partial! 'applicant', applicant: applicant
end
json.partial_applicants(vacancy.partial_applicants) do |applicant|
  json.partial! 'applicant', applicant: applicant
end
