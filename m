From: "Dan Carpenter" <error27@gmail.com>
Subject: Re: Moving smatch to use sparse
Date: Fri, 6 Oct 2006 01:57:06 -0700
Message-ID: <a63d67fe0610060157g117228fambc77363513a464d9@mail.gmail.com>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com>
	 <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com>
	 <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>
	 <45252A39.3050008@redhat.com>
	 <a63d67fe0610051358j6181f558p2baaf1b59b0a042e@mail.gmail.com>
	 <45258B4B.6010907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:23208 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751367AbWJFI5I (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Oct 2006 04:57:08 -0400
Received: by ug-out-1314.google.com with SMTP id o38so294052ugd
        for <linux-sparse@vger.kernel.org>; Fri, 06 Oct 2006 01:57:07 -0700 (PDT)
In-Reply-To: <45258B4B.6010907@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: smatch-discuss@lists.sourceforge.net, linux-sparse@vger.kernel.org

Sparse reads the source and creates a parse tree.  At the base, are
function symbols, the function has a bunch statements and the
statements have a bunch of expressions which branch out into even more
expressions.  If you have data that's a symbol.

struct expression is defined in expression.h
struct symbol is defined in symbol.h
struct statement is in parse.h

The important functions are:
set_state(name, my_id, sym, ISNULL);
get_state(deref, my_id, sym)
set_true_false_states(left, my_id, sym_left, ISNULL, NONNULL);
add_hook(&match_assign, ASSIGNMENT_HOOK);
void register_your_check(int id)
left = get_variable_from_expr(expr->left, &sym_left);
left = alloc_string(left);

my_id is a different int for every check script.
sym is a symbol * to the sparse symbol.
The condition hook feeds you one condition at a time.
add_hook() sets up a call back that will be called for every
assignment in this case.
add the register_your_check() to smatch.c.
get_variable_from_expr() is a bit buggy still but it's supposed to
give a string representation of an expression and it also gives you a
symbol pointer.  If you want to keep the string instead of just
printing it out or using it for get_state() then you have to call
alloc_string().

I haven't added setting up custom merge_rules yet.  Will do.

Internally smatch_states are a struct.  I'm going to add some more
fields to that so it might be useful to have a get_state_struct()
function...

smatch_flow.c interprets that sparse tree.  If you want to add another
hook that's the place to do it.

That's pretty much it.

regards,
dan carpenter
