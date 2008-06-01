From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: Undetected error cases
Date: Sun, 1 Jun 2008 20:55:32 +0200
Message-ID: <19f34abd0806011155h7954c55fucabc091a419709a8@mail.gmail.com>
References: <19f34abd0806011142x7e56fd8gf51358bf606ede91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:32434 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbYFASzd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2008 14:55:33 -0400
Received: by rv-out-0506.google.com with SMTP id l9so698560rvb.1
        for <linux-sparse@vger.kernel.org>; Sun, 01 Jun 2008 11:55:32 -0700 (PDT)
In-Reply-To: <19f34abd0806011142x7e56fd8gf51358bf606ede91@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Sun, Jun 1, 2008 at 8:42 PM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> I was playing with sparse to see what it would accept, and I was
> actually surprised at how many "obviously wrong" constructs it
> accepted. Because sparse is supposed to warn about this, isn't it? Or
> is there a policy not to warn about things that gcc already rejects?
> If that were the case, I believe it would reduce the overall
> usefulness of sparse.
>
> (I say "obviously wrong" because I don't see how they can be valid,
> but I might of course be mistaken :-))
>
> Anyway, here are my test cases:
>

Here are some more that all produce errors or at least warnings with
gcc but pass silently with sparse:

==> extern-struct.c <==
/* Empty declaration */
extern struct t {
};

==> inline-struct.c <==
/* "inline" has no meaning here. */
inline struct t {
};

==> struct-struct.c <==
/* What does this mean? */
struct struct {
};

==> struct-typedef.c <==
/* Anonymous typedef or struct named "typedef"? */
struct typedef {
};

==> typedef-cast.c <==
/* Cast to typedef doesn't make sense. */
static int x = (typedef int) 0;

==> typedef-struct.c <==
/* Anonymous typedef? */
typedef struct {
};


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
