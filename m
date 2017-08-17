From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Thu, 17 Aug 2017 20:28:29 +0100
Message-ID: <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
 <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com> <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35349 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbdHQT2a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:28:30 -0400
Received: by mail-ua0-f169.google.com with SMTP id q42so8059453uad.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:28:30 -0700 (PDT)
In-Reply-To: <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Luc,

On 17 August 2017 at 20:25, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 17, 2017 at 9:21 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>>> Apart from that I faced a problem with this and had to disable
>>>> STRUCT/UNION from being treated as simple types.
>>>
>>> That's only a problem/a limitation of your backend.
>>>
>>
>> Possibly - I haven't checked yet. Are you able to generate code / and
>> run the test case using your LLVM backend?
>
> Possibly not but you're the only use of the LLVM backend, so it's yours ;)
>

I will check at my end and revert with my thoughts.

But I would have preferred if the SSA change was like for like
initially - rather than introducing new breaking changes. That should
ideally come as patches later on.

Regards
Dibyendu
