From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Writing compilers, and example.c vs compile-i386.c
Date: Fri, 20 Jun 2008 18:40:14 -0700
Message-ID: <70318cbf0806201840k18a51f94rcaa413b36fcfbbea@mail.gmail.com>
References: <4856F196.8020403@cowlark.com>
	 <70318cbf0806161749u543fa338sf43a2ab787297eaa@mail.gmail.com>
	 <48584A33.7080602@cowlark.com>
	 <70318cbf0806171741g4d099e92vf0c0e9d7588fd7d6@mail.gmail.com>
	 <485C4150.2080508@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:55164 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbYFUBkS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Jun 2008 21:40:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so342923and.103
        for <linux-sparse@vger.kernel.org>; Fri, 20 Jun 2008 18:40:15 -0700 (PDT)
In-Reply-To: <485C4150.2080508@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Jun 20, 2008 at 4:46 PM, David Given <dg@cowlark.com> wrote:
> - how do you determine the scalar type of a pseudo?

Depend on the pseudo type. If pseudo from a symbol,
pseudo->sym->ctype has the full type information.

If pseudo is from constant expression, pseduo->def->val
is the constant expression. using expr->ctype to get to the ctype.

If pseudo is from normal instruction result, the target type is
the same as any source type. The special case the OP_CAST
instruction, the type is in insn->cast_type.

I agree we should probability make the ctype into instruction so
make the back end easier.

> - if I wish to rewrite a basic block's instruction list --- for example,
> to decompose instructions that use a non-register pseudo into two
> instructions --- do I need to do anything other than iterate through the
> bb's list and insert instruction nodes? Is there any additional
> housekeeping to do? Naturally, I'd do this *before* calling
> track_pseudo_death()...

If you modify instructions in a existing instruction list. Make sure you
keep the pseudo in SSA form, including proper user list.

If you add basic block, you need to update the parent and child list.

> - what does expand_symbol() do?

Well, it expand symbols. That does help does it?

Sparse parsing have a few stage.

The tokenizer parse the source code and convert it into token list.

Pre-process stage expand the macro and handle include files etc.

Parsing stage consume the token list and parse into AST tree.

Evaluate stage does the type propagation, pointer degenerate etc.

Expand stage is mostly for some fix up. E.g. remove obvious dead code
like "#if 0".
The inline function get expanded in this stage.

Hope that helps.

Chris
