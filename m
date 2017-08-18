From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 12:13:27 -0400
Message-ID: <CANeU7Qkf4D9QQhWR1s5mkUCrWn3ze96VkajuMkOCJg_fZciNcg@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CAExDi1RrEw4si8F9AEuHCrt9Zu7iDQ+btOysqciPVR=P-AQu4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33561 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdHRQN2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 12:13:28 -0400
Received: by mail-yw0-f180.google.com with SMTP id p68so61651553ywg.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 09:13:28 -0700 (PDT)
In-Reply-To: <CAExDi1RrEw4si8F9AEuHCrt9Zu7iDQ+btOysqciPVR=P-AQu4g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 3:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I agree it's confusing, and yes I would like a better name.
> OTOH 'registrable' is not exactly the conveyed meaning.
> 'register' is a concept that pertains to the backend, that
> is machine specific, a pseudo may need several registers
> and a register can hold several pseudos, ...

Sure, I saw your new name some thing like promote-able.
That is good.

>
> Here what we really want to select is something along:
> 'it's interesting to see it as a flow of value' vs.
> 'it's better to see it as a change in state'.
> And yes, very often that just correspond to registers.
>
> Note: it's not even 'what can be put in a pseudo(-register)'
>           were selecting here. It's OK to have pseudos for
>           'non-simple' values, They will just be transient and we
>           won't be interested in their 'flow'.

We need to be very careful about composite type pointer alias.
Any pointer alias to the member of the struct need to take
into account as well.

Chris
