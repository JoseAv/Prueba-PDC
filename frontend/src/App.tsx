import './App.css'
import { InfoPersona, InfoDepartamento, InfoPais } from './Tables/Tables'
import { useStore } from './Store/Data'
import { useState } from 'react'

function App() {

  const GetPersona = useStore((state) => state.GetPersona)
  const Getpais = useStore((state) => state.Getpais)
  const Getdep = useStore((state) => state.Getdep)
  const [handler, sethandler] = useState('')

  return (
    <>
      <h1>Tabla de datos</h1>

      <div className='container'>
        <aside className='container-button'>
          <button disabled={handler === 'pais' ? true : false} onClick={() => {
            sethandler('pais')
            Getpais()
          }}>Pais</button>
          <button disabled={handler === 'dep' ? true : false} onClick={() => {
            sethandler('dep')
            Getdep()
          }}>Departamento</button>
          <button disabled={handler === 'persona' ? true : false} onClick={() => {
            sethandler('persona')
            GetPersona()
          }}>Persona</button>
        </aside>

        <main className='container-main'>
          {!handler && <h2>No hay datos que mostrar</h2>}
          {handler === 'persona' ? <InfoPersona /> : null}
          {handler === 'dep' ? <InfoDepartamento /> : null}
          {handler === 'pais' ? <InfoPais /> : null}
        </main>
      </div>
    </>
  )
}

export default App
