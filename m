From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: fix bogus shift too big warning when rhs is a variable
Date: Sat, 28 Jun 2014 10:32:19 -0700
Message-ID: <CANeU7QkLdQuZbDA7jLd=6UrFJgevBO_y0B9n9va7_GTGfR+C0A@mail.gmail.com>
References: <20140616171006.GA20387@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:53455 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbaF1RcU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jun 2014 13:32:20 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so5572106qcr.21
        for <linux-sparse@vger.kernel.org>; Sat, 28 Jun 2014 10:32:19 -0700 (PDT)
In-Reply-To: <20140616171006.GA20387@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparse <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Josh Triplett <josh@joshtriplett.org>

Still catching up my emails.

On Mon, Jun 16, 2014 at 10:10 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> sparse warned about "shift too big" if the rhs was a variable.
> As sparse usually cannot deduct the value of a variable
> silence these warnings.

That is very strange. It should not happen.
>
> Before this patch following code snippet would generate a warning:
>
> static int doshift(int foo)
> {
>         return 1 << foo;
> }
>
> sparse did not know the value of 'foo' so reported a warning.
> Ignore the warning expect in the cases where the rhs of the shift
> is a constant.

That is strange. I can't duplicate the bug with your test case:
With tip of chrisl repository,
I get the following error with your test case:
./sparse /tmp/b.c
/tmp/b.c:3:18: warning: shift too big (1000) for type int
/tmp/b.c:8:22: warning: shift too big (1000) for type unsigned int


>
> diff --git a/expand.c b/expand.c
> index 0f6720c..ce955d3 100644
> --- a/expand.c
> +++ b/expand.c
> @@ -187,7 +187,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
>                 return 0;
>         r = right->value;
>         if (expr->op == SPECIAL_LEFTSHIFT || expr->op == SPECIAL_RIGHTSHIFT) {
> -               if (r >= ctype->bit_size) {
> +               if (right->flags & Int_const_expr && r >= ctype->bit_size) {


This does not explain why it fix the bug. In simplify_int_binop()
There is the code check for this is constant expr on rhs. The non
constant value should just bail out early.

    if (right->type != EXPR_VALUE)
        return 0;

That is right before your change. Plus I can't duplicate the bug myself.

I suspect there is something else going on. Any way to help me reproduce
the bug?

I am using gcc 4.8.2 on x86_64.

Chris
