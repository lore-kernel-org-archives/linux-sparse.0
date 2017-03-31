From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6 02/15] add table to "negate" some opcode
Date: Fri, 31 Mar 2017 21:18:38 +0200
Message-ID: <CAExDi1Q+4BJqHBnDidHetYrMb4W9K7YtmcLpZ4F2fmBZmFmOaA@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <20170327173405.11405-3-luc.vanoostenryck@gmail.com> <CANeU7QmA6HA3+HouCRpCpUWZMdDSq0m58cmj3H5gv+4m-1MVaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35568 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdCaTSk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 15:18:40 -0400
Received: by mail-qt0-f176.google.com with SMTP id x35so73440077qtc.2
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 12:18:39 -0700 (PDT)
In-Reply-To: <CANeU7QmA6HA3+HouCRpCpUWZMdDSq0m58cmj3H5gv+4m-1MVaQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 31, 2017 at 12:30 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Mar 28, 2017 at 1:33 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>
>> +
>> +const struct opcode_table opcode_table[OP_LAST] = {
>> +       [OP_SET_EQ] = { .negate = OP_SET_NE, },
>> +       [OP_SET_NE] = { .negate = OP_SET_EQ, },
>> +       [OP_SET_LT] = { .negate = OP_SET_GE, },
>> +       [OP_SET_LE] = { .negate = OP_SET_GT, },
>> +       [OP_SET_GE] = { .negate = OP_SET_LT, },
>> +       [OP_SET_GT] = { .negate = OP_SET_LE, },
>> +       [OP_SET_B ] = { .negate = OP_SET_AE, },
>> +       [OP_SET_BE] = { .negate = OP_SET_A , },
>> +       [OP_SET_AE] = { .negate = OP_SET_B , },
>> +       [OP_SET_A ] = { .negate = OP_SET_BE, },
>> +};
>
> The .negate member is only used by simplify_seteq_setne()
> Also the .swap member is only used by canonicalize_compare()
> in the later patch. Why not make it just two array local to those function
> who use it? I am not sure this need to be a global data structure.
> This is very minor, I can also accept it as it is.

I know, I have used a local table for the negate, then I needed one
for the swap and in the next series I needed another one for
"convert to float" relation. At that point it made more sense to use
a single table for all of them.
The .swap part is extended in the next series and the .negate part
will also be used in coming patches (some already written but not yet
published, some planned but not yet really written).

I think that things are clearer and cleaner like this.
I prefer to leave it as is for the moment.
(I realize that I'm not very receptive to small changes, sorry for that,
but I would like to focus more on a few big, fundamental issues).

> Also I would like to point out, at the code that use it. In a later patch.
> +       insn->opcode = opcode_table[insn->opcode].swap;
>
> That is a different behavior than the V4 patch. In the V4 patch
> if your input opcode is not in the compare group, the opcode
> is not changed. Here .negate and .swap will get to zero as opcode.
> You might want to check for that.

Yes, I've reorganised things a little bit but it's fine as it's only called
when it is known that the input opcode is one for which there must
be a valid entry in the table (in this case called in canonicalize_compare()
which itself is only called for OP_SET_LT, OP_SET_....)

-- Luc
