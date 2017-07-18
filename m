From: Christopher Li <sparse@chrisli.org>
Subject: Re: make selfcheck
Date: Tue, 18 Jul 2017 13:04:24 -0400
Message-ID: <CANeU7Qms_3VuKivHw20e6=MrWgRyVXJ_fJNTULSX3Y7AF9XqkQ@mail.gmail.com>
References: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com>
 <39e3d856-fd32-8059-10bb-ad1367e7d7a9@ramsayjones.plus.com>
 <CANeU7QmRaS8C8AyvtduDccK_w9pOjqppbMDoEDtyNH0OnN6ikw@mail.gmail.com>
 <ae7e6285-eb5b-9137-fab4-0ecc502aab7a@ramsayjones.plus.com>
 <CANeU7Q=7=w6WhCkg=KNfLOy5HMGizgO46zh+M_D6mK8AOASnNg@mail.gmail.com> <f9db8db5-ca7d-d83d-fa65-182d8b61f773@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34545 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdGRRE0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 13:04:26 -0400
Received: by mail-pg0-f45.google.com with SMTP id 123so16002683pgj.1
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 10:04:25 -0700 (PDT)
In-Reply-To: <f9db8db5-ca7d-d83d-fa65-182d8b61f773@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Jul 18, 2017 at 12:52 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Hmm, I don't think cgcc should be merged into sparse completely no.
> Some things from cgcc could be moved into sparse, but not everything.
> One of the main uses of cgcc is as a proxy for (g)cc. (Yes, that could
> also be moved into sparse, but why bother?)

I think the macro define etc should be merge to sparse. Right now
some kernel file compile differently because sparse missing some platform
specific macro. The last time I look at it, the coda file system has some
header file generating error in sparse.

I am thinking maybe have cgcc as symlink to sparse. If sparse
detect it is invoke from cgcc, it will do the call gcc part.

> I still have the 'intptr_t' and 'int32_t' warnings on cygwin, which I
> could solve either in cgcc or sparse (I was leaning in the direction
> of sparse, because Luc has already added some of these macros). These
> definitions would not cause any problems on the kernel (well, if they
> did, it would also be a problem with gcc!).

Right, that is my point sparse need to more of those macro to
behave more like gcc.

> However, I would not like to say whether some of the 'platform user
> space' macros would cause a problem on the kernel or not. The only
> way to know is to give it a try! (Unfortunately, due to lack of disk
> space, I have deleted my kernel git repository). :(

It is easy enough to compare for me. I can just turn a kernel check with
cgcc and see if there is any difference.

Chris
