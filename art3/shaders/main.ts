import GlslCanvas from 'glslCanvas';
import prefix from './prefix.glsl?raw';
import nested from './nested.glsl?raw';
import photo from '../gfx/stars.png';

document.addEventListener("DOMContentLoaded", (event) => {
    for (const el of document.getElementsByTagName('button')) {
        console.log(el);
        el.addEventListener('click', handleButton);
    }
    const canvas = document.getElementById("glslCanvas");
    const sandbox = new GlslCanvas(canvas);
    function addButton(name, shaderSrc) {
        const el = document.createElement('button');
        el.innerText = name;
        const f = () => {
            sandbox.load(prefix + shaderSrc);
            sandbox.loadTexture('../gfx/stars.png');
            sandbox.setUniform('u_tex0', '../gfx/stars.png');
            //sandbox.loadTexture(photo);
            console.log('texture loaded');
        };
        el.addEventListener('click', f);
        f();
        console.log(el);
        const buttonRow = document.getElementById('buttons');
        buttonRow.appendChild(el);
    }
    addButton('1', nested);
});
