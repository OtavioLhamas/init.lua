return {
    "dial.nvim",
    opts = function()
        local augend = require("dial.augend")

        local numeros_ordinarios = augend.constant.new({
            elements = {
                "primeiro",
                "segundo",
                "terceiro",
                "quarto",
                "quinto",
                "sexto",
                "sétimo",
                "oitavo",
                "nono",
                "décimo",
            },
            word = true,
            cyclic = true,
        })

        local numeros_ordinarias = augend.constant.new({
            elements = {
                "primeira",
                "segunda",
                "terceira",
                "quarta",
                "quinta",
                "sexta",
                "sétima",
                "oitava",
                "nona",
                "décima",
            },
            word = true,
            cyclic = true,
        })

        local dias_semana = augend.constant.new({
            elements = {
                "Segunda",
                "Terça",
                "Quarta",
                "Quinta",
                "Sexta",
                "Sábado",
                "Domingo",
            },
            word = true,
            cyclic = true,
        })

        local meses = augend.constant.new({
            elements = {
                "Janeiro",
                "Fevereiro",
                "Março",
                "Abril",
                "Maio",
                "Junho",
                "Julho",
                "Agosto",
                "Setembro",
                "Outubro",
                "Novembro",
                "Dezembro",
            },
            word = true,
            cyclic = true,
        })

        return {
            dials_by_ft = {
                cs = "cs",
            },
            groups = {
                default = {
                    numeros_ordinarios,
                    numeros_ordinarias,
                    dias_semana,
                    meses,
                    augend.constant.alias.bool,
                    augend.constant.new({
                        elements = { "and", "or" },
                        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    }),
                    augend.constant.new({
                        elements = { "&&", "||" },
                        word = false,
                        cyclic = true,
                    }),
                },
                cs = {
                    augend.constant.new({ elements = { "var", "const" } }),
                    augend.constant.new({ elements = { "public", "private" } }),
                },
            },
        }
    end,
}
