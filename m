From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Thu, 17 Aug 2017 21:14:49 +0200
Message-ID: <CAExDi1RrEw4si8F9AEuHCrt9Zu7iDQ+btOysqciPVR=P-AQu4g@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36109 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbdHQTOu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:14:50 -0400
Received: by mail-oi0-f54.google.com with SMTP id g131so76078499oic.3
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:14:50 -0700 (PDT)
In-Reply-To: <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 9:19 AM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> +static inline int is_simple_type(struct symbol *type)
> ...
>> +       case SYM_STRUCT:
>> +       case SYM_UNION:
>> +               return type->bit_size <= long_ctype.bit_size;
>
> I think the function name should be some thing along the
> line of "type fits register" or is_registerable_type.
>
> union and struct are composite types. It is a bit
> confusing calling them simple, if some one just looking
> at the code without look at the commit message.

I agree it's confusing, and yes I would like a better name.
OTOH 'registrable' is not exactly the conveyed meaning.
'register' is a concept that pertains to the backend, that
is machine specific, a pseudo may need several registers
and a register can hold several pseudos, ...

Here what we really want to select is something along:
'it's interesting to see it as a flow of value' vs.
'it's better to see it as a change in state'.
And yes, very often that just correspond to registers.

Note: it's not even 'what can be put in a pseudo(-register)'
          were selecting here. It's OK to have pseudos for
          'non-simple' values, They will just be transient and we
          won't be interested in their 'flow'.

-- Luc
