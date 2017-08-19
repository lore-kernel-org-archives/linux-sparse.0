From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Issue with bitfield
Date: Sat, 19 Aug 2017 22:18:15 +0200
Message-ID: <20170819201812.7ug7bu6dwjqoetip@ltop.local>
References: <CACXZuxeuyK0iJp1h5J8b1BmtTroQVsbfJqkeENG3=uNyyqvDoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37106 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdHSUSU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Aug 2017 16:18:20 -0400
Received: by mail-wm0-f43.google.com with SMTP id i66so22111020wmg.0
        for <linux-sparse@vger.kernel.org>; Sat, 19 Aug 2017 13:18:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxeuyK0iJp1h5J8b1BmtTroQVsbfJqkeENG3=uNyyqvDoQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 19, 2017 at 02:24:59AM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> This test program appears to generate incorrect IR.
> 
> extern int printf(const char *s, ...);
> 
> int main(void) {
> struct { char a:4; char b:4; } x = { 2, 4 };
> printf("a=%d b=%d\n", (int)x.a, (int)x.b);
> return 0;
> }


It's a very surprising bug. It's not a linearization or
an optimization bug as the AST is already wrong.
With a simpler test case, like:
	struct s {
		char a:4;
		char b:4;
	};
	
	int foo(void)
	{
		struct s x = { .a = 2, .b = 4 };
	
		return x.b;
	}

you can see that the linearization produce correct
code for the initializer.
You can also see that the return statement to be
linearized is something like
	STMT_RETURN
		ret_value: EXPR_VALUE (value = 2)

The EXPR_VALUE means that the expression is a constant
(which is indeed the case but I would expect that the
optimization has to deduce this) but it's value is wrong
(a quick check seems to indicate that whatever selected
by the x.<member> expression, it's always the value
of the first member that we get here.
It needs real investigation, though.
It would guess for a bug in the expansion or something.

Nice catch!

-- Luc
