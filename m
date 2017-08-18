From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 19:15:17 +0100
Message-ID: <CACXZuxd0aesRaQYqq8hzojxLQUfowZmdLT3c_8ZN2nUe6tbbzg@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
 <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
 <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
 <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com> <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:35602 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHRSPS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 14:15:18 -0400
Received: by mail-ua0-f170.google.com with SMTP id q42so17974479uad.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 11:15:18 -0700 (PDT)
In-Reply-To: <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 18 August 2017 at 17:18, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Aug 17, 2017 at 3:28 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I will check at my end and revert with my thoughts.
>>
>> But I would have preferred if the SSA change was like for like
>> initially - rather than introducing new breaking changes. That should
>> ideally come as patches later on.
>
> I just realized another side effect of doing the SSA conversion on
> the AST directly. It means we will not have access to the linearization
> byte code before promoting the memory variable to pseudo.
>
> If you are depending on that pre-simplified byte code, then you don't
> have a choice not do it. Maybe later on we can consider an option to
> avoid doing the SSA conversion on memory variable as an option.
>

I have it setup so that if optimization is switched off I skip the CSE
/ Flow Simplification steps. In the older version the
simplify_symbol_usage() was also being skipped but that is not used
now. (Although the way I have merged this - I have the old code still
there, and I can switch between the two implementations using a
#define).

As all my LLVM tests pass in this setup this is fine right now. I
still get failures in some cases when the other subsequent stages are
enabled - so there must be some incorrect simplifications occurring
somewhere. I do not yet have specific tests to track down where the
issues are.

As I mentioned before - ideally it would be good have a SSA step that
is reusable. Then you could run this step several times during the
process - and allow some simplification phases to generate non SSA
code. Perhaps the new SSA approach can be adapted for this. This would
also allow access to the first pass linearized output without
promotion to pseudos.

But this should not stop us from moving forward with this change - as
I think the SSA hooks into the linearization step are pretty specific
and it should be relatively easy to have a mode where those steps are
"dummied" - i.e. do nothing.

I have a question though. For my other backend I need liveness
analysis done even if I skip the other steps. Is it okay to run the
liveness analysis phase while skipping the CSE / Flow simplification
phases?

Regards
Dibyendu
