From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Accessing the list of #included files
Date: Wed, 11 Jun 2008 17:48:23 +0200
Message-ID: <20080611154823.GA12654@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:36738 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762295AbYFKPsg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Jun 2008 11:48:36 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2558470waf.23
        for <linux-sparse@vger.kernel.org>; Wed, 11 Jun 2008 08:48:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I am trying to write a program using sparse that will detect missing
includes (e.g. headers that have been included indirectly, but should
have been included explicitly).

Currently, I am only looking at functions (in fact, only calls), but
variables and data types may come later :-)

My question is: Is there a way to get a list of files that have been
included, for each file that has been parsed?

It thought that it might show up as a SYM_PREPROCESSOR symbol, but this
seems not to be the case.

I'm attaching the program as it looks so far, if anybody is interested.
Thanks for any help.


Vegard

--
#include <stdio.h>

#include "lib.h"
#include "symbol.h"
#include "expression.h"
#include "linearize.h"

static void check_call(struct symbol *file, struct symbol *function,
	struct pseudo *pseudo)
{
	struct position *file_pos;
	struct position *func_pos;
	struct position *call_pos;

	if (pseudo->type != PSEUDO_SYM)
		return;

	file_pos = &file->pos;
	func_pos = &function->pos;
	call_pos = &pseudo->sym->pos;

	/* Only process functions from the file we're currently checking. */
	if (func_pos->stream != file_pos->stream)
		return;

	/* Function was declared in the same file that it was used. */
	if (func_pos->stream == call_pos->stream)
		return;

	printf("%s needs to include %s\n",
		input_streams[func_pos->stream].name,
		input_streams[call_pos->stream].name);
}

static void check_block(struct symbol *file, struct symbol *function,
	struct basic_block *block)
{
	struct instruction *insn;

	FOR_EACH_PTR(block->insns, insn) {
		if (insn->opcode != OP_CALL)
			continue;

		check_call(file, function, insn->func);
	} END_FOR_EACH_PTR(insn);
}

static void check_entrypoint(struct symbol *file,
	struct entrypoint *entrypoint)
{
	struct basic_block *block;

	FOR_EACH_PTR(entrypoint->bbs, block) {
		check_block(file, entrypoint->name, block);
	} END_FOR_EACH_PTR(block);
}

static void check_symbols(struct symbol_list *list)
{
	struct symbol *sym;

	FOR_EACH_PTR(list, sym) {
		struct entrypoint *ep;

		expand_symbol(sym);
		ep = linearize_symbol(sym);
		if (ep)
			check_entrypoint(sym, ep);
	} END_FOR_EACH_PTR(sym);
}

int main(int argc, char *argv[])
{
	struct string_list *filelist = NULL;
	char *file;

	check_symbols(sparse_initialize(argc, argv, &filelist));

	FOR_EACH_PTR_NOTAG(filelist, file) {
		check_symbols(sparse(file));
	} END_FOR_EACH_PTR_NOTAG(file);

	return EXIT_SUCCESS;
}
