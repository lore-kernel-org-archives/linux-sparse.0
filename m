From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: barrier macro
Date: Tue, 1 May 2007 21:04:13 -0700
Message-ID: <20070501210413.d544d9eb.rdunlap@xenotime.net>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net>
	<463802E1.4030303@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:46017 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992692AbXEBEAG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 00:00:06 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 1 May 2007 20:59:59 -0700
In-Reply-To: <463802E1.4030303@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Tue, 01 May 2007 20:17:53 -0700 Josh Triplett wrote:

> Randy Dunlap wrote:
> > (using sparse 0.3)
> > 
> > ./compiler-gcc.h:10:#define barrier() __asm__ __volatile__("": : :"memory")
> > 
> > causes this output:
> > 
> > net/sunrpc/xprtsock.c:640:2: error: Expected ( after asm
> > net/sunrpc/xprtsock.c:640:2: error: got __volatile__
> > net/sunrpc/xprtsock.c:640:2: error: typename in expression
> > net/sunrpc/xprtsock.c:640:2: error: Expected ) in function call
> > net/sunrpc/xprtsock.c:640:2: error: got :
> > 
> > 
> > Maybe sparse could allow modifiers between asm|__asm__ and the
> > (...) ?
> 
> Sparse specifically allows volatile, and double-underscore variants, between the asm keyword and the open parenthesis:
> 
> static struct token *parse_asm_statement(struct token *token, struct statement *stmt)
> {
>         token = token->next;
>         stmt->type = STMT_ASM;
>         if (match_idents(token, &__volatile___ident, &__volatile_ident, &volatile_ident, NULL)) {
>                 token = token->next;
>         }
>         token = expect(token, '(', "after asm");
> [...]
> 
> 
> I cannot reproduce your report with the following test case (just added to git
> as validation/asm-volatile.c):

I'm doing this on i386 (x86_32).  Maybe that would help you.
It's trivial to reproduce.


> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> static void f(void)
> {
>         barrier();
> }
> 
> 
> Perhaps something else has caused the problem.  Could you please generate a
> preprocessed file with "make net/sunrpc/xprtsock.i", and strip it down to a
> minimal test case that still generates the Sparse warning?

Sure, I'll trim the 35000 lines down to a test case and get back
to you.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
