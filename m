From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Undetected error cases
Date: Sun, 1 Jun 2008 20:42:54 +0200
Message-ID: <19f34abd0806011142x7e56fd8gf51358bf606ede91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:21886 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYFASmz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2008 14:42:55 -0400
Received: by rv-out-0506.google.com with SMTP id l9so695705rvb.1
        for <linux-sparse@vger.kernel.org>; Sun, 01 Jun 2008 11:42:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I was playing with sparse to see what it would accept, and I was
actually surprised at how many "obviously wrong" constructs it
accepted. Because sparse is supposed to warn about this, isn't it? Or
is there a policy not to warn about things that gcc already rejects?
If that were the case, I believe it would reduce the overall
usefulness of sparse.

(I say "obviously wrong" because I don't see how they can be valid,
but I might of course be mistaken :-))

Anyway, here are my test cases:

==> const-void.c <==
/* "const void" has no meaning. */
const void f(void);

==> extern-parameter.c <==
/* "extern" in parameter declaration has no meaning. */
void f(extern int x);

==> inline-parameter.c <==
/* "inline" in parameter declaration has no meaning. */
void f(inline int x);

==> inline-typedef.c <==
/* "inline" is in front of "typedef". Is this equivalent to
 * "typedef inline int t"? Even so, it doesn't make sense to make variables
 * inline. */
inline typedef t;

==> inline-variable.c <==
/* "inline" for variables has no meaning. */
static inline int x = 0;

==> typedef-collision.c <==
/* Two types with the same name. The second one is used, but should it
 * be allowed? */
typedef char t;
typedef int t;

static t my_t = 0;

==> typedef-parameter.c <==
/* "typedef" in parameter declaration has no meaning. */
void f(typedef x);


None of these produce errors or even warnings when they are run
through sparse. I probably won't get around to fixing these myself
since I'm not that familiar with sparse internals. This is just a
heads up :-)


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
