From: Phil Carmody <phil@dovecot.fi>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Mon, 30 Jun 2014 11:56:03 +0300
Message-ID: <20140630085603.GB19158@phil.dovecot.net>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-1-git-send-email-phil@dovecot.fi>
 <20140627111900.GA19158@phil.dovecot.net>
 <CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:56448 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbaF3IzZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Jun 2014 04:55:25 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 27, 2014 at 10:16:23AM -0700, Christopher Li wrote:
> On Fri, Jun 27, 2014 at 4:19 AM, Phil Carmody <phil@dovecot.fi> wrote:
> >
> > Any comments on these?
> >
> 
> Sorry I am falling behind the patches, again.
> 
> I have been thinking about your patch for a few days.
> 
> It is very common to implicit cast up, do some binary operation
> then cast back down.  e.g.
> 
> 
> static unsigned long long val;
> static unsigned int ok10  = val | ~1u;
> static unsigned char a;
> static unsigned char ok11  = val | ~a;
> 
> 
> Your patch will give false positive warning about those.

Good call.

> Do you known how many new warning does it give on the new
> kernel build after apply your patch? I suspect there is a lot of
> false positive. I want to do that but haven't get around to it yet.
> Hint hint...

It found some things that I had intended to patch. My memory's hazy
though, and there's no point in making wild guesses. I'll do a couple
of builds again, with my patch and with your patch, and compare the
output. My builds will be powerpc ones, so if anyone wants to do an
x86 build it wouldn't be wasted effort.

> To reduce the false positive, we can check the zero extended bits
> survived to the final expression. e.g. the finial expression did
> down cast again and lost those bits. I also want an option to
> turn this warning off because the possible false positive.

The latter would make sense, yes. It's not clear how to achieve the
former though. Either some context needs to be passed down, or a flag
needs to be passed back up. Either could be a bit invasive.

> Also, if you only care about warning against up cast "~" of
> unsigned type, you can do the checking at cast_to().
> It will be simpler. I have a sort patch like this, given that I
> did not check for the "unsigned int" type, nor do I check for
> binary op. You can still get the idea.

It needs to check for unsigned-ness in order to trap zero-extension, though.

> In this way, you don't need to predict the up cast will happen
> or not. You can call when the implicit up cast actually happens.

That probably makes more sense. I was just mimicking the previous 
dubious check.

Will report back in the next day or so what the kernel builds say.

Cheers,
Phil

> It does not solve the problem of checking down cast  after up cast
> of finial expression though.
> 
> Chris
> 
> diff --git a/evaluate.c b/evaluate.c
> index 7ce8c55..47e660e 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -294,8 +294,11 @@ static struct expression * cast_to(struct
> expression *old, struct symbol *type)
>          */
>         switch (old->type) {
>         case EXPR_PREOP:
> -               if (old->ctype->bit_size < type->bit_size)
> +               if (old->ctype->bit_size < type->bit_size) {
> +                       if (old->op == '~')
> +                               warning(old->pos, "dubious zero-extended '~'");
>                         break;
> +               }
>                 if (old->op == '~') {
>                         old->ctype = type;
>                         old->unop = cast_to(old->unop, type);
