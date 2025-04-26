return {
    "dial.nvim",
    opts = function(_, opts)
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
            word = false,
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

        local logical_alias = augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
        })

        opts.dials_by_ft = LazyVim.merge(opts.dials_by_ft, {
            cs = "cs",
        })

        opts.groups.default = LazyVim.merge(opts.groups.default, {
            numeros_ordinarios,
            dias_semana,
            meses,
        })

        opts.groups.cs = {
            augend.integer.alias.decimal,
            augend.constant.alias.bool,
            augend.constant.new({ elements = { "var", "const" } }),
            augend.constant.new({ elements = { "public", "private" } }),
            logical_alias
        }

        opts.groups.markdown = LazyVim.merge(opts.groups.markdown, {
            numeros_ordinarios,
            dias_semana,
            meses,
        })

        return opts
    end,
}

