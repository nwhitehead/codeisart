import GlslCanvas from 'glslCanvas';
import prefix from './prefix.glsl?raw';
import nested from './conv.glsl?raw';

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
            sandbox.setUniform('u_tex0', '../gfx/stars.png');
            console.log('texture loaded');
        };
        el.addEventListener('click', f);
        f();
        console.log(el);
        const buttonRow = document.getElementById('buttons');
        buttonRow.appendChild(el);
    }
    const playpause = document.createElement('button');
    playpause.innerText = 'P';
    const buttonRow = document.getElementById('buttons');
    buttonRow.appendChild(playpause);
    let playing = true;
    playpause.addEventListener('click', () => {
        playing = !playing;
        if (playing) {
            sandbox.play();
        } else {
            sandbox.pause();
        }
    });
    addButton('1', nested);
});
