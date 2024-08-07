local ls = require("luasnip")
local utils = require("user.snippets.utils")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = utils.c
local c_d = utils.c_d
local c_c = utils.c_c

ls.add_snippets("typescript", {
	s({ trig = "nmod", desc = "NestJS Module" }, {
    t({     "import { Module } from '@nestjs/common';" }),
    t({ "", "import { TypeOrmModule } from '@nestjs/typeorm';" }),
    t({ "", "import {} from '@dishboard/entities';" }),
    t({ "", "import {} from '@dishboard/services';" }),
    t({ "", "import { " }), c(1), t("Service } from './"), c_d(1), t(".service';"),
    t({ "", "import { " }), c(1), t("Resolver } from './"), c_d(1), t(".resolver';"),
    t({ "", "" }),
		t({ "", "@Module({" }),
    t({ "", "  imports: [TypeOrmModule.forFeature[" }), i(2), t("]"), i(3), t("],"),
    t({ "", "  providers: [" }), c(1), t("Service, "), c(1), t("Resolver],"),
    t({ "", "  exports: [" }), c(1), t("Service],"),
    t({ "", "})" }),
    t({ "", "export class " }), i(1, "Name"), t({ "Module;", "" }),
  }),
})

ls.add_snippets("typescript", {
  s({ trig = "nser", desc = "NestJS Service" }, {
    t({     "import { Injectable } from '@nestjs/common';" }),
    t({ "", "import { InjectRepository } from '@nestjs/typeorm';" }),
    t({ "", "import { Repository } from 'typeorm';" }),
    t({ "", "import {} from '@dishboard/entities';" }),
    t({ "", "import {} from '@dishboard/services';" }),
    t({ "", "" }),
    t({ "", "@Injectable()" }),
    t({ "", "export class " }), i(1, "Name"), t("Service {"),
    t({ "", "  constructor(" }),
    t({ "", "    @InjectRepository(" }), i(2, "Entity"), t(")"),
    t({ "", "    private readonly " }), c_c(2), t("Repository: Repository<"), c(2), t(">,"),
    t({ "", "  ) {}" }),
    t({ "", "" }),
    t({ "", "  " }), i(0),
    t({ "", "}" }),
  }),
})

ls.add_snippets("typescript", {
  s({ trig = "inrep", desc = "Inject repository" }, {
    t({     "@InjectRepository(" }), i(1, "Entity"), t(")"),
    t({ "", "private readonly " }), c_c(1), t("Repository: Repository<"), c(1), t(">,"),
  }),
})

ls.add_snippets("typescript", {
  s({ trig = "inser", desc = "Inject service" }, {
    t({ "private readonly " }), c_c(1), t(": "), i(1, "Service"), t(","),
  }),
})

ls.add_snippets("typescript", {
  s({ trig = "nres", desc = "NestJS Resolver" }, {
    t({     "import { UseGuards } from '@nestjs/common'" }),
    t({ "", "import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';" }),
    t({ "", "import { " }), c(1), t("Service } from './"), c_d(1), t(".service';"),
    t({ "", "" }),
    t({ "", "@UseGuards(GqlAuthGuard)" }),
    t({ "", "export class " }), i(1, "Name"), t("Resolver {"),
    t({ "", "  constructor(" }),
    t({ "", "    private readonly " }), c_c(1), t("Service: "), c(1), t("Service,"),
    t({ "", "  ) {}" }),
    t({ "", "" }),
    t({ "", "  " }), i(0),
    t({ "", "}" }),
  }),
})
