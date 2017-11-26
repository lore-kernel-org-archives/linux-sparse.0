From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: function designators & function pointers
Date: Sun, 26 Nov 2017 22:58:13 +0100
Message-ID: <20171126215812.iswufpk3cssq2hdf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39962 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdKZV6R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Nov 2017 16:58:17 -0500
Received: by mail-wm0-f43.google.com with SMTP id b189so31164471wmd.5
        for <linux-sparse@vger.kernel.org>; Sun, 26 Nov 2017 13:58:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>

I've found some problems with the linearization of
function calls and/or their evaluation.
But I would like first to be sure of what is wanted here.

The problems turn around the fact that in the C standards:
1) a function designator is usually implicitly converted to a
   function pointer (C11 6.3.2.1p4)
	"(except with 'sizeof' ...) a function designator with type
	 ‘function returning type’ is converted to an expression
	  that has type ‘pointer to function returning type’".
2) for function calls (C11 6.5.2.2p1):
	"The expression that denotes the called function
	 (Most often, this is the result of converting an
	 identifier that is a function designator) shall have
	 type 'pointer to function returning ...'"
3) for the '*' operator and functions (C11 6.5.3.2p4):
	"If the operand points to a function, the result is a
	 function designator; ... If the operand has type
	 ‘pointer to type’, the result has type ‘type’".


So, my understanding of the standard is that the following
function calls are all strictly equivalent (and GCC seems to agree):

	extern int foo(void);

	foo();
	(foo)();
	(*foo)();
	(**foo)();
	(***foo)();
	// and so on

Same for the following ones:
	extern int (*bar)(void);

	bar();
	(bar)();
	(*bar)();
	(**bar)();
	(***bar)();
	// and so on


On both cases we can add as much '*' as we want: each one produces
a function designator that is/should directly be re-converted to
a function pointer (and the function pointer is then used for the
cal in itself).

Currently, sparse doesn't like those 'unneeded dereferences'.
Do we want to accept them?
Do we want to warn on them (because they're really weird, unneeded
and thus maybe the sign of some errors)?

-- Luc
