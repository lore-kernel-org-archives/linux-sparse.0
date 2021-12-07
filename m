Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD23C433F5
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Dec 2021 14:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhLGOKc (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Dec 2021 09:10:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhLGOKc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Dec 2021 09:10:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 32FD62191E;
        Tue,  7 Dec 2021 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638886021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wbRgmW+zXCMvnhV8IL0lLlGP7x2MmNNduatTHF949cM=;
        b=Xj7/H93LNsHKEZ85IPanm73ZEWuaacvjcEMW3xDov2m4KgUmrIL1hNzmB8cVBS/xcCh2br
        uUD4TvxU3DXi+M6pS7u3fBvFz/xlDO7Go+4jqbS1GZ72vI/wUUpf8nMm6BGR6RLCEnjsq0
        bzW2urfD7wv4H50wrxRtBBcyKe1uAIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638886021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wbRgmW+zXCMvnhV8IL0lLlGP7x2MmNNduatTHF949cM=;
        b=sZEb/42EJDZArLoCY2ijly9UG952rU03536IHIVyEIVUfT6Qur+UitbbBt8SmY2lGPE9g4
        KQsrpSM1GNNJNcBQ==
Received: from g78 (unknown [10.163.17.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B4C6FA3B8C;
        Tue,  7 Dec 2021 14:07:00 +0000 (UTC)
User-agent: mu4e 1.6.9; emacs 27.2
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     linux-sparse@vger.kernel.org
Cc:     pvorel@suze.cz, chrubis@suse.cz, io@richiejp.com
Subject: Linux Test Project vendored Sparse
Date:   Tue, 07 Dec 2021 13:33:56 +0000
Reply-To: rpalethorpe@suse.de
Message-ID: <87k0ggbjb0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hello Sparse contributors,

After trying a number of static analysis tools we settled on Sparse to
roll our own C checks. There are some mistakes we see repeatedly when
people are trying to write tests. Some of these are specific to the
LTP's API, so we decided to try our own analysis.

So far we have checks for:

LTP-001	Library source files have tst_ prefix
LTP-002	TST_RET and TST_ERR are never modified by test library functions
LTP-003 Externally visible library symbols have the tst_ prefix
LTP-004 Test executable symbols are marked static
LTP-005 Array must terminate with a sentinel value (i.e. NULL or '{}')
*       Deprecated symbols from the old API

We use a mixture of the linearized form and AST. If you are interested
please see:
https://github.com/linux-test-project/ltp/blob/master/tools/sparse/
Also I will attach the main code to the body of this e-mail it is only
283 lines.

I still don't have a firm grasp on how Sparse works, so any feedback
would be welcome. BTW we include Sparse as a git module and so far there
have been no complaints.

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
 *
 * Sparse allows us to perform checks on the AST (struct symbol) or on
 * a linearized representation. In the latter case we are given a set
 * of entry points (functions) containing basic blocks of
 * instructions.
 *
 * The basic blocks contain byte code in SSA form. This is similar to
 * the intermediate representation most compilers use during
 * optimisation.
 */
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <fcntl.h>

#include "lib.h"
#include "allocate.h"
#include "opcode.h"
#include "token.h"
#include "parse.h"
#include "symbol.h"
#include "expression.h"
#include "linearize.h"

/* The rules for test, library and tool code are different */
enum ltp_tu_kind {
	LTP_LIB,
	LTP_OTHER,
};

static enum ltp_tu_kind tu_kind = LTP_OTHER;

/* Check for LTP-002
 *
 * Inspects the destination symbol of each store instruction. If it is
 * TST_RET or TST_ERR then emit a warning.
 */
static void check_lib_sets_TEST_vars(const struct instruction *insn)
{
	static struct ident *TST_RES_id, *TST_ERR_id;

	if (!TST_RES_id) {
		TST_RES_id = built_in_ident("TST_RET");
		TST_ERR_id = built_in_ident("TST_ERR");
	}

	if (insn->opcode != OP_STORE)
		return;
	if (insn->src->ident != TST_RES_id &&
	    insn->src->ident != TST_ERR_id)
		return;

	warning(insn->pos,
		"LTP-002: Library should not write to TST_RET or TST_ERR");
}

static void do_basicblock_checks(struct basic_block *bb)
{
	struct instruction *insn;

	FOR_EACH_PTR(bb->insns, insn) {
		if (!bb_reachable(insn->bb))
			continue;

		if (tu_kind == LTP_LIB)
			check_lib_sets_TEST_vars(insn);
	} END_FOR_EACH_PTR(insn);
}

static void do_entrypoint_checks(struct entrypoint *ep)
{
	struct basic_block *bb;

	FOR_EACH_PTR(ep->bbs, bb) {
		do_basicblock_checks(bb);
	} END_FOR_EACH_PTR(bb);
}

/* The old API can not comply with the rules. So when we see one of
 * these symbols we know that it will result in further
 * warnings. Probably these will suggest inappropriate things. Usually
 * these symbols should be removed and the new API used
 * instead. Otherwise they can be ignored until all tests have been
 * converted to the new API.
 */
static bool check_symbol_deprecated(const struct symbol *const sym)
{
	static struct ident *TCID_id, *TST_TOTAL_id;
	const struct ident *id = sym->ident;

	if (!TCID_id) {
		TCID_id = built_in_ident("TCID");
		TST_TOTAL_id = built_in_ident("TST_TOTAL");
	}

	if (id != TCID_id && id != TST_TOTAL_id)
		return false;

	warning(sym->pos,
		"Ignoring deprecated API symbol: '%s'. Should this code be converted to the new API?",
		show_ident(id));

	return true;
}

/* Check for LTP-003 and LTP-004
 *
 * Try to find cases where the static keyword was forgotten.
 */
static void check_symbol_visibility(const struct symbol *const sym)
{
	const unsigned long mod = sym->ctype.modifiers;
	const char *const name = show_ident(sym->ident);
	const int has_lib_prefix = !strncmp("tst_", name, 4) ||
		!strncmp("TST_", name, 4) ||
		!strncmp("ltp_", name, 4) ||
		!strncmp("safe_", name, 5);

	if (!(mod & MOD_TOPLEVEL))
		return;

	if (has_lib_prefix && (mod & MOD_STATIC) && !(mod & MOD_INLINE)) {
		warning(sym->pos,
			"LTP-003: Symbol '%s' has the LTP public library prefix, but is static (private).",
			name);
		return;
	}

	if ((mod & MOD_STATIC))
		return;

	if (tu_kind == LTP_LIB && !has_lib_prefix) {
		warning(sym->pos,
			"LTP-003: Symbol '%s' is a public library function, but is missing the 'tst_' prefix",
			name);
		return;
	}

	if (sym->same_symbol)
		return;

	if (sym->ident == &main_ident)
		return;

	warning(sym->pos,
		"Symbol '%s' has no prototype or library ('tst_') prefix. Should it be static?",
		name);
}

/* See base_type() in dissect.c */
static struct symbol *unwrap_base_type(const struct symbol *sym)
{
	switch (sym->ctype.base_type->type) {
	case SYM_ARRAY:
	case SYM_NODE:
	case SYM_PTR:
		return unwrap_base_type(sym->ctype.base_type);
	default:
		return sym->ctype.base_type;
	}
}

/* Checks if some struct array initializer is terminated with a blank
 * (zeroed) item i.e. {}
 */
static bool is_terminated_with_null_struct(const struct symbol *const sym)
{
	const struct expression *const arr_init = sym->initializer;
	const struct expression *item_init =
		last_ptr_list((struct ptr_list *)arr_init->expr_list);

	if (item_init->type == EXPR_POS)
		item_init = item_init->init_expr;

	return ptr_list_empty((struct ptr_list *)item_init->expr_list);
}

/* Check for (one instance of) LTP-005
 *
 * The tags array is only accessed when the test fails. So we perform
 * a static check to ensure it ends with {}
 */
static void check_tag_initializer(const struct symbol *const sym)
{
	if (is_terminated_with_null_struct(sym))
		return;

	warning(sym->pos,
		"LTP-005: test.tags array doesn't appear to be null-terminated; did you forget to add '{}' as the final entry?");
}

/* Find struct tst_test test = { ... } and perform tests on its initializer */
static void check_test_struct(const struct symbol *const sym)
{
	static struct ident *tst_test, *tst_test_test, *tst_tag;
	struct ident *ctype_name = NULL;
	struct expression *init = sym->initializer;
	struct expression *entry;

	if (!sym->ctype.base_type)
		return;

	ctype_name = sym->ctype.base_type->ident;

	if (!init)
		return;

	if (!tst_test_test) {
		tst_test = built_in_ident("tst_test");
		tst_test_test = built_in_ident("test");
		tst_tag = built_in_ident("tst_tag");
	}

	if (sym->ident != tst_test_test)
		return;

	if (ctype_name != tst_test)
		return;

	FOR_EACH_PTR(init->expr_list, entry) {
		if (entry->init_expr->type != EXPR_SYMBOL)
			continue;

		const struct symbol *entry_init = entry->init_expr->symbol;
		const struct symbol *entry_ctype = unwrap_base_type(entry_init);

		if (entry_ctype->ident == tst_tag)
			check_tag_initializer(entry_init);
	} END_FOR_EACH_PTR(entry);

}

/* AST level checks */
static void do_symbol_checks(struct symbol *sym)
{
	if (check_symbol_deprecated(sym))
		return;

	check_symbol_visibility(sym);
	check_test_struct(sym);
}

/* Compile the AST into a graph of basicblocks */
static void process_symbols(struct symbol_list *list)
{
	struct symbol *sym;

	FOR_EACH_PTR(list, sym) {
		struct entrypoint *ep;

		do_symbol_checks(sym);

		expand_symbol(sym);
		ep = linearize_symbol(sym);
		if (!ep || !ep->entry)
			continue;

		do_entrypoint_checks(ep);

		if (dbg_entry)
			show_entry(ep);
	} END_FOR_EACH_PTR(sym);
}

static void collect_info_from_args(const int argc, char *const *const argv)
{
	int i;

	for (i = 0; i < argc; i++) {
		if (!strcmp("-DLTPLIB", argv[i]))
			tu_kind = LTP_LIB;
	}
}

int main(int argc, char **argv)
{
	struct string_list *filelist = NULL;
	char *file;

	Waddress_space = 0;
	Wbitwise = 0;
	Wcast_truncate = 0;
	Wcontext = 0;
	Wdecl = 0;
	Wexternal_function_has_definition = 0;
	Wflexible_array_array = 0;
	Wimplicit_int = 0;
	Wint_to_pointer_cast = 0;
	Wmemcpy_max_count = 0;
	Wnon_pointer_null = 0;
	Wone_bit_signed_bitfield = 0;
	Woverride_init = 0;
	Wpointer_to_int_cast = 0;
	Wvla = 0;

	do_output = 0;

	collect_info_from_args(argc, argv);

	process_symbols(sparse_initialize(argc, argv, &filelist));
	FOR_EACH_PTR(filelist, file) {
		process_symbols(sparse(file));
	} END_FOR_EACH_PTR(file);

	report_stats();
	return 0;
}


