# frozen_string_literal: true

require 'rails_helper'

feature 'head sends feedback' do
  scenario 'sucessfully' do
    head = create(:head)
    job_vacancy = create(:job_vacancy, head: head)
    applicant = create(:applicant)
    create(:job_opening, job_vacancy: job_vacancy,
                         applicant: applicant)

    login_as head, scope: :head

    visit root_path
    click_on 'Ver detalhes'
    click_on 'Recusar e enviar Feedback'
    fill_in 'Mensagem', with: 'hoje sim'
    click_on 'Enviar'

    expect(current_path).to eq(job_vacancy_path(job_vacancy))
    expect(page).to have_content('Feedback enviado')
  end
  scenario 'cannot be blank' do
    head = create(:head)
    job_vacancy = create(:job_vacancy, head: head)
    applicant = create(:applicant)
    create(:job_opening, job_vacancy: job_vacancy,
                         applicant: applicant)

    login_as head, scope: :head

    visit root_path
    click_on 'Ver detalhes'
    click_on 'Recusar e enviar Feedback'
    fill_in 'Mensagem', with: ''
    click_on 'Enviar'

    expect(current_path).to eq(job_vacancy_feedbacks_path(job_vacancy))
    expect(page).to have_content('Mensagem não pode ficar em branco')
  end
  scenario 'already exists' do
    head = create(:head)
    job_vacancy = create(:job_vacancy, head: head)
    applicant = create(:applicant)
    job_opening = create(:job_opening, job_vacancy: job_vacancy,
                                       applicant: applicant)
    create(:feedback, job_opening: job_opening)

    login_as head, scope: :head

    visit root_path
    click_on 'Ver detalhes'
    click_on 'Recusar e enviar Feedback'

    expect(current_path).to eq(job_vacancy_path(job_vacancy))
    expect(page).to have_content('Feedback já enviado')
  end
end
