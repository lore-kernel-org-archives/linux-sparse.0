From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Fri, 27 Jun 2014 10:16:23 -0700
Message-ID: <CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
	<1402386847-23477-1-git-send-email-phil@dovecot.fi>
	<20140627111900.GA19158@phil.dovecot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:58940 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbaF0RQX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2014 13:16:23 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so4571532qgd.19
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2014 10:16:23 -0700 (PDT)
In-Reply-To: <20140627111900.GA19158@phil.dovecot.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Phil Carmody <phil@dovecot.fi>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 27, 2014 at 4:19 AM, Phil Carmody <phil@dovecot.fi> wrote:
>
> Any comments on these?
>

Sorry I am falling behind the patches, again.

I have been thinking about your patch for a few days.

It is very common to implicit cast up, do some binary operation
then cast back down.  e.g.


static unsigned long long val;
static unsigned int ok10  = val | ~1u;
static unsigned char a;
static unsigned char ok11  = val | ~a;


Your patch will give false positive warning about those.

Do you known how many new warning does it give on the new
kernel build after apply your patch? I suspect there is a lot of
false positive. I want to do that but haven't get around to it yet.
Hint hint...

To reduce the false positive, we can check the zero extended bits
survived to the final expression. e.g. the finial expression did
down cast again and lost those bits. I also want an option to
turn this warning off because the possible false positive.

Also, if you only care about warning against up cast "~" of
unsigned type, you can do the checking at cast_to().
It will be simpler. I have a sort patch like this, given that I
did not check for the "unsigned int" type, nor do I check for
binary op. You can still get the idea.

In this way, you don't need to predict the up cast will happen
or not. You can call when the implicit up cast actually happens.

It does not solve the problem of checking down cast  after up cast
of finial expression though.

Chris

diff --git a/evaluate.c b/evaluate.c
index 7ce8c55..47e660e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -294,8 +294,11 @@ static struct expression * cast_to(struct
expression *old, struct symbol *type)
         */
        switch (old->type) {
        case EXPR_PREOP:
-               if (old->ctype->bit_size < type->bit_size)
+               if (old->ctype->bit_size < type->bit_size) {
+                       if (old->op == '~')
+                               warning(old->pos, "dubious zero-extended '~'");
                        break;
+               }
                if (old->op == '~') {
                        old->ctype = type;
                        old->unop = cast_to(old->unop, type);
