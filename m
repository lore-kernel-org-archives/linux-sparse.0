From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 23 Nov 2016 11:12:02 +0800
Message-ID: <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34166 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755409AbcKWD24 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 22:28:56 -0500
Received: by mail-io0-f195.google.com with SMTP id r94so222312ioe.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 19:28:56 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Mon, Feb 1, 2016 at 10:28 AM, Nicolai Stange <nicstange@gmail.com> wrote:
> Here comes the greatly enhanced v3 of this series.
>
> Luc's suggestions about splitting some patches turned out to be very fruitful!

OK, I am taking a stab at his again. Sorry for the long hold off.
I will reply from this thread instead of finding the right patch email
to reply on.

+++ validation/constexpr-cast.c 2016-11-23 09:57:37.638646787 +0800
@@ -0,0 +1,25 @@
+static int a[] = {
+       [(int)0] = 0,           // OK
+       [(int)(int)0] = 0,      // OK
+       [(int)0.] = 0,          // OK
+       [(int)(int)0.] = 0,     // OK
+       [(int)__builtin_choose_expr(0, 0, 0)] = 0,      // OK
+       [(int)__builtin_choose_expr(0, 0, 0.)] = 0,     // OK
+
+       [(int)(float)0] = 0,    // KO

Why is this one KO? It seems perfectly fine to force a floating
type into a integer constant expression.

per [6.6.6]  quote: on integer constant expression:
 " and floating constants that are the
immediate operands of casts. Cast operators in an integer constant
expression shall only
convert arithmetic types to integer types,"

+       [(int)(float)0.] = 0,   // KO
+
+       [(int)(void*)0] = 0,    // KO

Also this one should be fine?

[6.7.8.6] quote as
" If a designator has the form
[ constant-expression ]
then the current object (defined below) shall have array type and the
expression shall be
an *integer constant expression*."

So it seems the only requirement is *integer constant expression*.
why (int)(void*)0 is not integer constant expression? Sure there is
a warning about converting the (void*) into (int) for a different size.
But that is a separate issue.

Chris
