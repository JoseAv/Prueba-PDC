"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class ControllerApi {
    static ShowUser(req, res) {
        console.log('hOLA DESDE OTRO LADO');
        res.send('<h2>Adios</h2>');
    }
}
exports.default = ControllerApi;
