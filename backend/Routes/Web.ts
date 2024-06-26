import { Router } from "express";
import ControllerApiWeb from '../Controller/WebC'

export const RouterWeb = Router()


RouterWeb.get('/pais', ControllerApiWeb.ShowPais)
RouterWeb.get('/per', ControllerApiWeb.ShowPersona)
RouterWeb.get('/dep', ControllerApiWeb.ShowDepartamento)
