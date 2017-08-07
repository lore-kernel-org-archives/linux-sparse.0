From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Sun, 6 Aug 2017 21:44:49 -0400
Message-ID: <CANeU7Q=tQ07sKBkxfrjktwGmR+ggDtiu_NQOEpYnje7Y2S6CYA@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk3trZmFqyGuhOxBLzFBOT131o=HhNhwQrzLrHoO2PQ1Q@mail.gmail.com>
 <20170806234441.vcpux6zyhfsfef3c@ltop.local> <CANeU7QnxyV2cXvvErVsX_7MivK5AO+7TEsxf=rCvX+seoOf94A@mail.gmail.com>
 <20170807012059.3xfmohmfebof4bot@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36492 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdHGBou (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:44:50 -0400
Received: by mail-pg0-f47.google.com with SMTP id v77so27845025pgb.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:44:50 -0700 (PDT)
In-Reply-To: <20170807012059.3xfmohmfebof4bot@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 9:21 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>
> No, directly from symbol to pseudos.
> It's the beauty of this approach.

I have to read more when I have time.
>
>> Directly from the linearize process?
>
> Yes, only the add_load() & add_store() is modified and
> instead of storing stuff in memory, it's directly translated
> to pseudos & phi-nodes are created when needed.

How does it deal with pointer usage analyze?

>> > More specifically, you can do what is needed in a BB
>> > once you have all the parents, otherwise you need to
>> > delay things. The article call this 'BB is sealed'
>> > and there is a 'seal' operation that need to be called
>> > to process what was delayed.
>> > Complications arise with gotos (and the article doesn't
>> > talk about them) but I've added a solution for it
>> > (but I would like to return to it later).
>>
>> I am missing the obvious. Where is this article?
>
> I've put the reference at the top of the new file sssa.c:
> /*
>  * This is an implementation of the SSA construction algorithm:
>  *      "Simple and Efficient Construction of Static Single Assignment Form"
>  * by Matthias Braun, Sebastian Buchwald, Sebastian Hack, Roland Leissa,
>  *    Christoph Mallon and Andreas Zwinkau.
>  * cfr. http://www.cdl.uni-saarland.de/papers/bbhlmz13cc.pdf
>  */

Interesting. I will take a look.

>> > Another thing I would like to change is the ptrmap
>> > implementation I've added: it need to be hash-table based
>> > (but it's only an implementation detail that matters
>> > for performance on really big functions).
>>
>> Which ptrmap? The one used for CSE?
>
> No, no.
> I needed a map between symbols and pseudos.
> It's in a separate file: ptrmap.c

OK, there is a back end pointer in symbol->aux
you can use to store information relate to back end.
pseudo->priv is the similar deal.

Using this two pointers do you still need the ptrmap?

Chris
