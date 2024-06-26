"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RouterWeb = void 0;
const express_1 = require("express");
const WebC_1 = __importDefault(require("../Controller/WebC"));
exports.RouterWeb = (0, express_1.Router)();
exports.RouterWeb.get('/', WebC_1.default.ShowUser);
