From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v4 03/63] canonicalize compare instructions
Date: Thu, 23 Mar 2017 22:12:28 -0700
Message-ID: <CANeU7Qkhygbv5xBHKicwJDRdDY-EJctauxvLoz33wZ_keeqXHQ@mail.gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com> <20170321001607.75169-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:32774 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdCXFM3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 01:12:29 -0400
Received: by mail-io0-f172.google.com with SMTP id f84so10692000ioj.0
        for <linux-sparse@vger.kernel.org>; Thu, 23 Mar 2017 22:12:29 -0700 (PDT)
In-Reply-To: <20170321001607.75169-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Mon, Mar 20, 2017 at 5:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


> +static int compare_swap(int opcode)

This function can be call "swap_compare", the action part is
swap.

> +{
> +       switch (opcode) {
> +       case OP_SET_EQ: return OP_SET_EQ;
> +       case OP_SET_NE: return OP_SET_NE;
> +
> +       case OP_SET_LT: return OP_SET_GT;
> +       case OP_SET_LE: return OP_SET_GE;
> +       case OP_SET_GT: return OP_SET_LT;
> +       case OP_SET_GE: return OP_SET_LE;
> +
> +       case OP_SET_A:  return OP_SET_B;
> +       case OP_SET_AE: return OP_SET_BE;
> +       case OP_SET_B:  return OP_SET_A;
> +       case OP_SET_BE: return OP_SET_AE;

Some very minor micro optimization note.
I take a look at the machine code it generated. It actually generate
a jump table and each jump table has some label entry corresponding
to code fragment like:

movl $28, %eax #, _163
.LVL985:
jmp .L701 #

I think it should be better to use a static array to directly
fetch the new opcode. There is OP_BINCMP and OP_BINCMP_END
to mark the begin and end of the binary compare opcode. That
way there one data table not jump table for control flow.

This comment apply to comparere_opcode() which introduce in the
earlier patch as well.

Chris
