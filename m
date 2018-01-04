From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] proper handling of #pragma
Date: Fri, 5 Jan 2018 01:42:40 +0800
Message-ID: <CANeU7QkPd43nBga-YOMv6p8NYesH4U7ao+AsZiz=ZCc12diJMA@mail.gmail.com>
References: <20180103161419.a43208d5469c43ff36b3d2e1@redchan.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f173.google.com ([209.85.213.173]:39802 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbeADRml (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 Jan 2018 12:42:41 -0500
Received: by mail-yb0-f173.google.com with SMTP id f201so907911ybg.6
        for <linux-sparse@vger.kernel.org>; Thu, 04 Jan 2018 09:42:41 -0800 (PST)
In-Reply-To: <20180103161419.a43208d5469c43ff36b3d2e1@redchan.it>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: foobar <foobar@redchan.it>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jan 4, 2018 at 12:14 AM, foobar <foobar@redchan.it> wrote:
> #pragma directives other than #pragma once are not really meant for the preprocessor to consume.

I am not sure I understand this. #pragma is not part of the normal C
language grammar.
It should be consumed at the preprocessor stage, it has some side effect
for the compiler.

>
> in preprocessor_only mode, apart from pragma once, they should all be printed to stdout (unless they are under #ifdef that's not taken).

I wonder what does the C spec say about this.

> i've produced a patch that does that, however i'm not really happy about it, since i'm unclear about how to deal
> with the pragma in non-preprocessor mode.
>
> i suppose the token-stream of the pragma-directive should be converted into some kind of special symbol, which can then be either consumed or ignored when doing the usual iteration over the symbol list.
> but i didn't find an obvious symbol type to assign...

If it is preprocessor symbol. It does not need to have C type. It can
have the name space
set to preprocessor. In theory you can also have a symbol_list keep track of
all the pragma you see in the source file. Not sure that will serve
you any purpose.

> (my plan is to create a build tool based on sparse that gets directives as a special pragma).
>
> thanks!
>
> testcode:
> #pragma once
> #if 1
> #pragma omp wanna "see this" in cpp output
> #else
> #pragma omp nope "this one not"
> #endif
>
> here's the initial version of my patch
>
> Subject: [PATCH] preprocessor: properly emit #pragma directives
>
> 3 months after the first commit, handling of pragma directives was
> implemented, with the idea of turning the token into __pragma__ for
> later internal consumption. however never anything came out of this idea,
> and #pragma was basically left broken. apart from #pragma once, the
> directive needs to persist in the preprocessor output, it is for later
> consumption of the compiler (apparently the assumption was that sparse
> would never be used as a stand-alone preprocessor).

If __pragma__ exist pass the preprocessor stage.
It can appear in any part of the C source file. The C parser need
to consume it at almost any context. That will really complicate stuff.
I think that is a bad idea.

There might be other ways to do what you want.

If it is pre-processor only, then that might be fine. Because there is
no C parser to consume the output.

Chris
