From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/3] allow builtins to have prototype and evaluate/expand methods
Date: Wed, 8 Feb 2017 06:19:45 +0800
Message-ID: <CANeU7Qno3xVT5CemAsm2R1JtLRcX=_OrpzykvfAzc16CLOf_Nw@mail.gmail.com>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
 <20170123213728.89900-3-luc.vanoostenryck@gmail.com> <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
 <20170207201253.4i2ye6inqwma65rf@macpro.local> <CANeU7QnfuFjr_bZRqeED8Q54xcm-yeo9-=R8vVHbhvt8ukjxTQ@mail.gmail.com>
 <20170207213448.ah3tjuifg6iwpahg@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32917 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755409AbdBGWTq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 17:19:46 -0500
Received: by mail-it0-f65.google.com with SMTP id e137so13730909itc.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 14:19:46 -0800 (PST)
In-Reply-To: <20170207213448.ah3tjuifg6iwpahg@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 8, 2017 at 5:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> I see roughly a way how we could do that but I'm far from being
> convinced it would be a good idea.
> The problem is not that we have one symbol per declaration, it's
> even not that we have several symbols for the same object, it's
> that we don't have a central place holding the information about
> the object.  Like, for example, we can't answer something essential
> like "what is the type of this function" because we have as much
> types as we have declarations.

As far as I can tell. You can't have one single place to hold type for
every declaration. If the declaration is exactly the same, yes.
But if the declaration was done in difference scope with different
incremental declare, you need to have different version of the same
symbol due to the C specification of scoping. See my previous example.
The field "same_symbol" is for that purpose tracking the same symbol
in different declares.

> So yes, verification of the
> comptability between the declarations and consolidate them is what
> is missing.

I think in evaluate.c check_duplicates() does the verification of incompatible
declares already. I agree consolidating is missing right now.

I am open to suggestions how to fix it.

Chris
