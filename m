From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v1 18/28] scope: make function_scope invalid outside
 functions
Date: Tue, 19 May 2020 22:57:00 +0200
Message-ID: <20200519205700.n52dgvp4npgldrey@ltop.local>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-19-luc.vanoostenryck@gmail.com>
 <CAHk-=wgSBgpXKfMD=yC1B6vH-YxP+6y_KUBuDODXB_i=K7sdNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESU5E (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 16:57:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5FC08C5C0
        for <linux-sparse@vger.kernel.org>; Tue, 19 May 2020 13:57:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l5so679429edn.7
        for <linux-sparse@vger.kernel.org>; Tue, 19 May 2020 13:57:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSBgpXKfMD=yC1B6vH-YxP+6y_KUBuDODXB_i=K7sdNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, May 18, 2020 at 06:38:17PM -0700, Linus Torvalds wrote:
> On Mon, May 18, 2020 at 5:57 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > So, mainly in preparation for some incoming changes, let
> > function_scope's parent be NULL instead of the builtin scope.
> 
> Hmm. Gcc nested functions?
> 
> Sparse doesn't _support_ them, but the symbol nesting part actually
> does work, afaik. This looks like it might break it.

Hmm yes. I was barely aware that nested functions were at least parsed
but I had absolutely not internalized that and indeed this patch
assumes that leaving the function will return to the file scope.

But well this patch maybe made some sense at some stage but was
probably a bad idea, even more so with the nested functions.
So I'm dropping it and making the corresponding adjustments
in the next 2 patches.

Thank you for noticing this.

> Yes, gcc function nesting is disgusting. But it's a thing.
> 
> Stupid test-case that almost works with sparse:
> 
>     int test(int a, int b)
>     {
>         inline int nested(int i)
>         {
>                 return a*2 + i;
>         }
>         return nested(b);
>     }
> 
> and by "almost works with sparse" I mean that it actually linearizes
> correctly, even if it's mostly by mistake, and you get a warning about
> 
>     t.c:5:24: warning: unreplaced symbol 'a'
> 
> because sparse really doesn't support nested functions and it really
> only works because of inlining.

I see, interesting. I only saw this "unreplaced symbol" message a very
few tmes and never understood its cause (I don't think it was related
to a nested function but it makes more sense now).

-- Luc
