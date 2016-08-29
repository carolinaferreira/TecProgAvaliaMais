Feature: Login
	To use application resources
	As a system user
	I would like to log in with my account

	Scenario: Log in a valid user
		Given I am on the log in page
		And I fill in "Apelido ou e-mail" with "robot"
		And I fill in "Senha" with "123456"
		When I press "Entrar" button
		Then the initial page should load with notice message "Login realizado com sucesso"

	Scenario: Invalid user error
		Given I am on the log in page
		And I fill in "Apelido ou e-mail" with "invalidbot"
		And I fill in "Senha" with "123456"
		When I press "Entrar" button
		Then the login page should reload with notice message "Login ou senha inválidos"