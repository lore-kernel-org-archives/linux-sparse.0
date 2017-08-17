From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Thu, 17 Aug 2017 17:59:04 +0100
Message-ID: <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35410 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbdHQQ7F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 12:59:05 -0400
Received: by mail-ua0-f193.google.com with SMTP id r9so1225914uad.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 09:59:05 -0700 (PDT)
In-Reply-To: <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 17 August 2017 at 08:19, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Here by 'simple' we really mean 'worth of putting in a register'.
>>
>> We select all scalar types as well as struct and unions with a
>> size not bigger than a long (register).
>>
>> Global and static variables, variables which address have been
>> taken and volatiles variables are never selected.
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  symbol.h | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/symbol.h b/symbol.h
>> index 327449611..3f075c5bc 100644
>> --- a/symbol.h
>> +++ b/symbol.h
>> @@ -407,6 +407,39 @@ static inline int is_scalar_type(struct symbol *type)
>>         return 0;
>>  }
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
>

Apart from that I faced a problem with this and had to disable
STRUCT/UNION from being treated as simple types.

The problem was when generating LLVM output for
https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/eic/testcbrt.c.
I will investigate more and report back my findings.

Meanwhile I would be interested to see the results of a test with above.

Regards
Dibyendu
