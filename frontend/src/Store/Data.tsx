import { create } from "zustand";
import { persona, pais, departamento } from "../Types/Data";

interface typeStore {
    persona: persona[] | []
    pais: pais[] | []
    dep: departamento[] | []
    GetPersona: () => void
    Getdep: () => void
    Getpais: () => void
}


export const useStore = create<typeStore>((set) => ({
    persona: [],
    pais: [],
    dep: [],

    GetPersona() {
        fetch('http://localhost:4000/per').then(res => res.json()).then(resolve => set({ persona: resolve }))
    },

    Getpais() {
        fetch('http://localhost:4000/pais').then(res => res.json()).then(resolve => set({ pais: resolve }))
    },

    Getdep() {
        fetch('http://localhost:4000/dep').then(res => res.json()).then(resolve => set({ dep: resolve }))
    },




}))