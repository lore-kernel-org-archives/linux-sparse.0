From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v1 22/28] bad-goto: jumping inside a statemet expression
 is an error
Date: Wed, 20 May 2020 18:37:42 +0200
Message-ID: <20200520163742.qvqp6nqwge5ezmoi@ltop.local>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-23-luc.vanoostenryck@gmail.com>
 <0d16af30-3797-3ba8-24b9-5a5697345537@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETQhp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 May 2020 12:37:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB47C061A0E
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 09:37:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id f13so3162161edr.13
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 09:37:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0d16af30-3797-3ba8-24b9-5a5697345537@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, May 20, 2020 at 01:53:51AM +0100, Ramsay Jones wrote:
> On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> > It's invalid to jump inside a statement expression.
> > 
> > So, detect such jumps, issue an error message and mark the
> > function as useless for linearization since the resulting IR
> > would be invalid.

...

> > +static void warn_label_usage(struct position def, struct position use, struct ident *ident)
> 
> you are issuing an error report from this function, so should it be
> called, something like, 'label_usage_error'?

Yes, it's a bit confusing. I hesitated on the name when writting it.
The logic is that most functions in this file (and other files too)
are named following the verb+object pattern and I don't have a good
(short) verb for 'issue an diagnostic message'. 'label_usage_error'
sounds to me more like the name for a variable. In standardese
maybe 'diagnose' could be used but ... no, thanks. The way I see it
is that the verb/action 'warn' can be realized in 2 ways:
issue a warning message or issue an error message.

In fact, I really would prefer to fold this function with its check.
It was how it was written at some stage but the function needed 5
arguments and was quite hard to read.
 
Best regards,
-- Luc
