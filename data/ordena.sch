
create table GL_Contacto(
	ID integer not null primary key identity,
	Nombres varchar(50) not null,
	Apellidos varchar(50) not null,
	DocumentoID varchar(11) not null,
	DocTipo varchar(1) not null default 'C' check (DocTipo in ('C', 'P', 'R')), /* C = Cedula, P = Pasaporte, R = RNC */
	ContTipo varchar(1) not null check ('C', 'P', 'I', 'S', 'E', 'T'), /* C = Cliente, P = Propietario, I = Inquilino, S= Suplidor, E = Empleado, T=Contacto */
	  
	Sexo varchar(1) not null check (Sexo in ('M', 'F')), /* M = Masculino, F = Femenino */
	EstadoCivil varchar(1) not null check (EstadoCivil in ()), /*S = Soltero, C = Casado U = Union Libre*/
	Ocupacion varchar(60),
	

); go