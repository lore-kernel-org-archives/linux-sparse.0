From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Mon, 6 Nov 2017 07:18:46 +0800
Message-ID: <CANeU7QkXyUonK-wKjrGp_Ka6vBsFaJ65S3OvjMzLTKc8VUoW4w@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
 <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com> <20171105171013.mktkihyuuagqthaq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:53748 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdKEXSr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 18:18:47 -0500
Received: by mail-yw0-f176.google.com with SMTP id q126so6466466ywq.10
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 15:18:47 -0800 (PST)
In-Reply-To: <20171105171013.mktkihyuuagqthaq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 6, 2017 at 1:10 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> >-              insn->opcode = compare_opcode(opcode, inverse);
>> >+              insn->opcode = inverse ? opcode_table[opcode].negate : opcode;
>>
>> I think it would be better to have some kind of assert check here, the opcode
>> you swap from the table is indeep opcode. Because you assign the opcode
>> array using sparse index. It is easy to miss a spot creating the empty slot in
>> the table.
>
> Sorry, I see the words, I sorta gues what you mean but I can't parse
> what you wrote.

Let me re phrase. The opcode_table has a lot of zero in them.
Even though you thing you give all the op code worthwhile to have .negate
an opcode. The rest of op has .negate to zero.

My suggestion is that make a assert check this new opcode you get back
from the table is not zero.

You initialize the op code table using position index. It is possible to missing
a slot. So have an assert check here is good.

>
>> Also, the opcode table might be able to compressed only contain
>> section of the BINCMP opcodes.
>
> Yes, it's something that may be done after all the related changes
> are done if the speedup is worth the added complexity.

This series will first go into a topic branch any way.
Clearly your opcode is only apply to OP_SETXXXX friends.
I more compact data section is good.


Chris
