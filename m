From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 5 Nov 2017 16:29:57 +0800
Message-ID: <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com> <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:53774 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdKEI36 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 03:29:58 -0500
Received: by mail-yw0-f180.google.com with SMTP id q126so5590960ywq.10
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 01:29:58 -0700 (PDT)
In-Reply-To: <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

>commit e4a0824120939235e40277a57425a72fbfcd5b9b
>Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>Date:   Sun Mar 26 19:35:14 2017 +0200
>
>    add table to "negate" some opcode
>
>    Some optimizations transform an instruction opcode
>    into another. For example, it may be needed to know
>    the opcode corresponding to the negation of a comparison.
>
>    This patch make this easy and flexible by adding a table
>    for the relation between opcodes.

>+const struct opcode_table opcode_table[OP_LAST] = {
>+      [OP_SET_EQ] = { .negate = OP_SET_NE, },
>+      [OP_SET_NE] = { .negate = OP_SET_EQ, },
>+      [OP_SET_LT] = { .negate = OP_SET_GE, },
>+      [OP_SET_LE] = { .negate = OP_SET_GT, },
>+      [OP_SET_GE] = { .negate = OP_SET_LT, },
>+      [OP_SET_GT] = { .negate = OP_SET_LE, },
>+      [OP_SET_B ] = { .negate = OP_SET_AE, },
>+      [OP_SET_BE] = { .negate = OP_SET_A , },
>+      [OP_SET_AE] = { .negate = OP_SET_B , },
>+      [OP_SET_A ] = { .negate = OP_SET_BE, },
>+};

I think this patch ideally should be combined with the next patch.
As it is, this patch is not self contain. There is no user of this table.


>commit b38e2263075d1caa7694f47cc5f1cc8d78a2871d
>Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>Date:   Mon Mar 27 17:19:43 2017 +0200
>
>    use opcode table for compare_opcode()
>
>    At the same time, change also the name of the function.
>
...
> static int simplify_seteq_setne(struct instruction *insn, long long value)
> {
>       pseudo_t old = insn->src1;
>@@ -484,7 +460,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
>               // and similar for setne/eq ... 0/1
>               src1 = def->src1;
>               src2 = def->src2;
>-              insn->opcode = compare_opcode(opcode, inverse);
>+              insn->opcode = inverse ? opcode_table[opcode].negate : opcode;

I think it would be better to have some kind of assert check here, the opcode
you swap from the table is indeep opcode. Because you assign the opcode
array using sparse index. It is easy to miss a spot creating the empty slot in
the table.

Also, the opcode table might be able to compressed only contain
section of the BINCMP opcodes.

Chris
