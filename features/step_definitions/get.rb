Dado('que o usuario consulte informacoes de funcionario') do
  @get_url = "https://dummy.restapiexample.com/api/v1/employees"
  end

Quando('ele realizar a pesquisa') do
  @list_employee = HTTParty.get(@get_url)
  end

Entao('uma lista de funcionarios deve retornar') do
  expect(@list_employee.code).to eql 200
  expect(@list_employee.message).to eql 'OK'
  end

 
Dado('que o usuario cadastre um novo funcionario') do
  @post_url = 'http://dummy.restapiexample.com/api/v1/create'
  end
  
Quando('ele enviar as informacoes do funcionario') do
  @create_employee = HTTParty.post(@post_url, :headers => {'Content-Type': 'application/json'}, body: {
    "id": 27,
    "employee_name": "Tony",
    "employee_salary": 420800,
    "employee_age": 30,
    "profile_image": ""
}.to_json)
 end

Entao('esse funcionario sera cadastrado') do
expect(@create_employee.code).to eql (200)
expect(@create_employee.msg).to eql 'OK'
expect(@create_employee["status"]).to eql 'success'
expect(@create_employee["message"]).to eql 'Successfully! Record has been added.'
expect(@create_employee['data']["employee_name"]).to eql 'Tony'
expect(@create_employee['data']["employee_salary"]).to eql (420800)
expect(@create_employee['data']["employee_age"]).to eql (30)

  end


  Dado('que o usuario altere uma informacao de funcionario') do
    @put_url = 'https://dummy.restapiexample.com/api/v1/update/10'
    end
  
  Quando('ele enviar as novas informacoes') do
    @update_employee = HTTParty.put(@put_url, :headers => {'Content-Type': 'application/json'}, body: {
     "employee_name": "Alberto",
    "employee_salary": 100,
    "employee_age": 40,
    "profile_image": ""
  }.to_json)


    end
  
  Entao('as informacoes serao alteradas') do
    expect(@update_employee.code).to eql (200)
    expect(@update_employee.msg).to eql 'OK'
    expect(@update_employee["status"]).to eql 'success'
    expect(@update_employee["message"]).to eql 'Successfully! Record has been updated.'
    expect(@update_employee['data']["employee_name"]).to eql 'Alberto'
    expect(@update_employee['data']["employee_salary"]).to eql (100)
    expect(@update_employee['data']["employee_age"]).to eql (40)

    end


    Dado('que o usuario queira deletar um funcionario') do
      @get_employee = HTTParty.get('https://dummy.restapiexample.com/api/v1/employees',:headers => {'Content-Type': 'application/json'})
      @delete_url = 'https://dummy.restapiexample.com/api/v1/delete/' + @get_employee['data'][0]['id'].to_s
          end
    
    Quando('ele enviar a identificacao unica') do
      @delete_employee = HTTParty.delete(@delete_url, :headers => {'Content-Type': 'application/json'})
      puts @delete_employee
          end
    
    Entao('esse funcionario sera deletado do sistema') do
      expect(@delete_employee.code).to eql (200)
      expect(@delete_employee.msg).to eql 'OK'
      expect(@delete_employee["status"]).to eql 'success'
      expect(@delete_employee["data"]).to eql '27'
      expect(@delete_employee["message"]).to eql 'Successfully! Record has been deleted.'
          end