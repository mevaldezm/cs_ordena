
create table AL_Empresa(

	ID integer not null primary key identity,
	Nombre varchar(80) not null,
	Rnc varchar(11),
	Direccion varchar(100),
	Telefono varchar(10),
	Fax varchar(10),
	Correo varchar(256),
	Website varchar(50)
); 


create table GL_Contacto(

	ID integer not null primary key identity,
	Nombres varchar(50) not null,
	Apellidos varchar(50) not null,
	DocumentoID varchar(11) not null,
	DocumentoTipo varchar(1) not null default 'C' check (DocumentoTipo in ('C', 'P', 'R')), /* C = Cedula, P = Pasaporte, R = RNC */
	ContactoTipo varchar(1) not null check ( ContactoTipo in ('C', 'P', 'I', 'S', 'E', 'G', 'T')), /* C = Cliente, P = Propietario, I = Inquilino, S= Suplidor, E = Empleado, T=Contacto */
	Sexo varchar(1) not null check (Sexo in ('M', 'F')), /* M = Masculino, F = Femenino */
	EstadoCivil varchar(1) not null check (EstadoCivil in ('S', 'C', 'U')), /*S = Soltero, C = Casado U = Union Libre*/
	Ocupacion varchar(60),
	Correo varchar(256),
	TelefonoResidencia varchar(15),
	TelefonoCelular varchar(15),
	TelefonoOficina varchar(20),
	TelefonoFax varchar(10),
	TelefonoOtro varchar(15),
	TelefonoContacto varchar(20),
	NombreContacto varchar(100),
	OcupacionContacto varchar(50),
	SectorID integer not null,
	ProvinciaID integer not null,
	Direccion varchar(100) not null,
	Observacion varchar(256),
	foreign key (SectorID) references GL_Sector(ID),
	foreign key (ProvinciaID) references GL_Provincia(ID)
	
); 


create table GL_Sector(
   ID integer not null primary key identity,
   NombreSector varchar(50) not null
); 

create table GL_Provincia(
   ID integer not null primary key identity,
   NombreProvincia varchar(50) not null
); 

create table AL_Cliente(
    ID integer not null primary key identity,
	ContactoID integer not null,
	CuentaID integer not null,
	Estado varchar(1) not null default 'A' check (Estado in ('A', 'I')), /* A = Activo, I = Inactivo */
	foreign key (ContactoID) references GL_Contacto(ID)
); 

create table GL_Banco(
	ID integer not null primary key identity,
	NombreBanco varchar(80)
); 

create table AL_Cuenta(
   AL_ClienteID int not null,
   AL_BancoID integer not null,
   CuentaNumero integer not null,
   foreign key (AL_ClienteID) references AL_Cliente(ID),
   foreign key (AL_BancoID) references GL_Banco(ID)
); 


create table AL_InmuebleTipo(
   ID integer not null primary key identity,
   InmuebleTipoDescr varchar(30) not null

)

create table AL_Inmueble(
	ID integer not null primary key identity,
	AL_ClienteID integer not null,
	GL_SectorID integer,
	GL_ProvinciaID integer,
	AL_InmuebleTipoID integer not null,
	Edificio varchar(30),
	Direccion varchar(120) not null,
	Disponible varchar(1) not null check (Disponible in ('S', 'N')),
	Condicion varchar(1),
	AreaConstruccion integer,
	AreaSolar integer,
	NumeroHabitaciones smallint,
	NumeroPaqueos smallint,
	NumeroBannos smallint,
	NumeroPisos smallint,
	NumeroNiveles smallint default 1,
	NumeroDepositos smallint,
	CuotaMantenimiento money,
	CuotaAlquiler money,
	CuotaDeposito money,
	ServicioElectrico varchar(1)  check (ServicioElectrico in ('S', 'N')),
	ServicioAgua varchar(1)  check (ServicioAgua in ('S', 'N')),
	ServicioCable varchar(1)  check (ServicioCable in ('S', 'N')),
	PlantaElectrica varchar(1)  check (PlantaElectrica in ('S', 'N', 'F')),
	HabitacionServicio varchar(1)  check (HabitacionServicio in ('S', 'N')),
	Desayunador varchar(1)  check (Desayunador in ('S', 'N')),
	Balcon varchar(1)  check (Balcon in ('S', 'N')),
	Cisterna varchar(1) check (Cisterna in ('S', 'N')),
	Jardin varchar(1)  check (Jardin in ('S', 'N')),
	Terraza varchar(1) check (Terraza in ('S', 'N')),
	Salarestar varchar(1)  check (Salarestar in ('S', 'N')),
	Sala varchar(1) check (Sala in ('S', 'N')),
	SalaComedor varchar(1)  check (SalaComedor in ('S', 'N')),
	Estudio varchar(1)  check (Estudio in ('S', 'N')),
	Elevador varchar(1)  check (Elevador in ('S', 'N')),
	AireAcondicionado varchar(1)  check (AireAcondicionado in ('S', 'N')),
	Closet varchar(1)  check (Closet in ('S', 'N')),
	Cocina varchar(1)  check (Cocina in ('S', 'N')),
	Inversor varchar(1)  check (Inversor in ('S', 'N')),
	Tinaco varchar(1)  check (Tinaco in ('S', 'N')),
	Piscina varchar(1)  check (Piscina in ('S', 'N')),
	Jacuzzi varchar(1)  check (Jacuzzi in ('S', 'N')),
	WalkingCloset varchar(1)  check (WalkingCloset in ('S', 'N')),
	Observacion varchar(256),
	foreign key (AL_ClienteID) references AL_Cliente(ID),
	foreign key (GL_ProvinciaID) references GL_Provincia(ID),
	foreign key (AL_InmuebleTipoID) references AL_InmuebleTipo(ID),
    foreign key (GL_SectorID) references GL_Sector(ID)
);
 create table AL_Contrato(
    PropietarioID integer not null,
	InquilinoID integer not null,
	InmuebleID integer not null,
	FechaContrato Date not null,
	FechaVencimiento Date,
	FechaRescinsion Date,
	FechaCortePago Date,
	Mora float,
	foreign key (PropietarioID) references AL_Cliente(ID),
    foreign key (InquilinoID) references AL_Cliente(ID),
    foreign key (InmuebleID) references AL_Inmueble(ID)
 );

 create table GL_Usuario(

    NombreUsuario varchar(50) not null primary key,
	NombreDespliegue varchar(50) not null,
	Clave varchar(128),
	FechaCreacion date,
	FechaExpira date,
	Estado varchar(1) not null default 'A' check (Estado in ('A', 'I')), /* A = Activo, I = Inactivo */

 );


