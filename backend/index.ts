import express from "express";
import cors from 'cors'
import { RouterWeb } from './Routes/Web'
import { RouterApp } from './Routes/app'

const app = express()
app.use(express.json())
app.use(cors())
const PORT = 4000


app.use('/', RouterWeb)
app.use('/app', RouterApp)


app.listen(PORT, () => {
    console.log('Listen on port', PORT)
})