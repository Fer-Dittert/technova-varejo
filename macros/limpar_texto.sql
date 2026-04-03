{% macro limpar_texto(coluna) %}
    trim(lower({{ coluna }}))
{% endmacro %}