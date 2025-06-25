shader_type canvas_item;

uniform float wave_strength = 0.02;
uniform float wave_speed = 2.0;
uniform float transparency = 0.6; // прозрачность отражения

void fragment() {
    vec2 uv = UV;
    
    // создаём волны по горизонтали на основе времени и вертикальной позиции
    uv.y += sin(UV.x * 10.0 + TIME * wave_speed) * wave_strength;

    // получаем цвет из текстуры
    vec4 tex_color = texture(TEXTURE, uv);

    // создаём затухание вниз по вертикали (UV.y = 0 вверху, 1 внизу)
    float fade = 1.0 - UV.y;

    // финальный цвет с рябью, затуханием и прозрачностью
    COLOR = tex_color * vec4(1.0, 1.0, 1.0, fade * transparency);
}
