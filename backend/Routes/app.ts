import { Router } from "express";
import ControllerAppSendData from '../Controller/SendApp'
import ControllGetApp from '../Controller/GetApp'
import ControllPerson from '../Controller/PersonApp'
export const RouterApp = Router()

// Busqueda de datos por id
RouterApp.get('/pais/:id', ControllerAppSendData.SendPais)
RouterApp.get('/dep/:id', ControllerAppSendData.SendDepartamento)
RouterApp.get('/per/:id', ControllerAppSendData.SendPersona)


// Pais 
RouterApp.post('/pais', ControllGetApp.InsertPais)
RouterApp.put('/pais/:id', ControllGetApp.UpdatePais)

// Departamento
RouterApp.post('/dep', ControllGetApp.InsertDep)
RouterApp.put('/dep/:id', ControllGetApp.UpdateDep)

// Persona
RouterApp.post('/per', ControllPerson.InsertPer)
RouterApp.put('/per/:id', ControllPerson.UpdatePer)
RouterApp.delete('/per/:id', ControllPerson.DeletePer)