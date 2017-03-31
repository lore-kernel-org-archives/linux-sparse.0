From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v6 02/15] add table to "negate" some opcode
Date: Fri, 31 Mar 2017 18:30:06 +0800
Message-ID: <CANeU7QmA6HA3+HouCRpCpUWZMdDSq0m58cmj3H5gv+4m-1MVaQ@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com> <20170327173405.11405-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33591 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbdCaKaI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 06:30:08 -0400
Received: by mail-io0-f172.google.com with SMTP id f84so36707450ioj.0
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 03:30:07 -0700 (PDT)
In-Reply-To: <20170327173405.11405-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 1:33 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> +
> +const struct opcode_table opcode_table[OP_LAST] = {
> +       [OP_SET_EQ] = { .negate = OP_SET_NE, },
> +       [OP_SET_NE] = { .negate = OP_SET_EQ, },
> +       [OP_SET_LT] = { .negate = OP_SET_GE, },
> +       [OP_SET_LE] = { .negate = OP_SET_GT, },
> +       [OP_SET_GE] = { .negate = OP_SET_LT, },
> +       [OP_SET_GT] = { .negate = OP_SET_LE, },
> +       [OP_SET_B ] = { .negate = OP_SET_AE, },
> +       [OP_SET_BE] = { .negate = OP_SET_A , },
> +       [OP_SET_AE] = { .negate = OP_SET_B , },
> +       [OP_SET_A ] = { .negate = OP_SET_BE, },
> +};

The .negate member is only used by simplify_seteq_setne()
Also the .swap member is only used by canonicalize_compare()
in the later patch. Why not make it just two array local to those function
who use it? I am not sure this need to be a global data structure.
This is very minor, I can also accept it as it is.

Also I would like to point out, at the code that use it. In a later patch.
+       insn->opcode = opcode_table[insn->opcode].swap;

That is a different behavior than the V4 patch. In the V4 patch
if your input opcode is not in the compare group, the opcode
is not changed. Here .negate and .swap will get to zero as opcode.

You might want to check for that.

Chris
