From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: complain about re-declared functions with different modifiers
Date: Thu, 14 May 2020 11:18:53 -0700
Message-ID: <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
References: <20200514140451.GD2078@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgENSTN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 May 2020 14:19:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200CC061A0C
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 11:19:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w10so4639104ljo.0
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 11:19:12 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r19sm1968400ljp.68.2020.05.14.11.19.09
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 11:19:09 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id u15so4619725ljd.3
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 11:19:09 -0700 (PDT)
In-Reply-To: <20200514140451.GD2078@kadam>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, May 14, 2020 at 7:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> But then it's re-declared as not inline.
>
> Could Sparse print a warning for that?

I actually think that would be a bug.

Having a non-inline declaration for an inline function sounds normal
and correct and even expected. I'd not be surprised at all if a
function is declared in a header file as non-inline (because there it
is), but then in the implementation it's defined as inline (because
later uses in that same file might want to inline it).

So warning about inline/non-inline differences is I think actively wrong.

HOWEVER.

In this case I wonder if the real difference is that first we have a
"static" definition of the symbol, and then later there's a non-static
declaration of it. That, to me, smells a bit odd - one has file scope,
the other has external scope, and particularly with the external scope
coming _after_ the file scope, which version of that same symbol does
a subsequent use then use?

Because a static symbol and a symbol with external linkage are clearly
not the same symbol. It's perfectly fine to have an external symbol
'x' that is shadowed by a static symbol 'x' in file scope.

But I wonder if smatch sees the *external* symbol nvme_put_ctrl()
(which doesn't have an inline definition!) rather than the static one
(which does!) because the external declaration comes after the static
definition.

So _that_ might be worth warning about: seeing an external declaration
after a static one makes for confusion.

I'm not sure that is the problem here.

                Linus
