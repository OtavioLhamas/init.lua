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

        local and_or = augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
        })

        table.insert(opts.groups.default, numeros_ordinarios)
        table.insert(opts.groups.default, numeros_ordinarias)
        table.insert(opts.groups.default, dias_semana)
        table.insert(opts.groups.default, meses)
        table.insert(opts.groups.default, augend.date.alias["%Y-%m-%d"])
        table.insert(opts.groups.default, augend.date.alias["%d/%m/%Y"])

        opts.dials_by_ft.cs = "cs"
        opts.groups.cs = {
            augend.constant.new({ elements = { "var", "const" } }),
            augend.constant.new({ elements = { "public", "private", "protected" } }),
            augend.semver.alias.semver,
        }

        opts.dials_by_ft.xml = "xml"
        opts.groups.xml = {
            augend.semver.alias.semver,
        }

        return opts
    end,
}
