From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 6/8] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Mon, 7 Aug 2017 20:22:59 -0400
Message-ID: <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-7-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33193 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHHAXA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 20:23:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id c65so1777609pfl.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 17:23:00 -0700 (PDT)
In-Reply-To: <20170807191205.86590-7-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 3:12 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This is especially usefull when simplifying code
> accessing bitfields.
>
>
> +static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long value)
> +{
> +       struct instruction *def;
> +       unsigned long long mask;
> +
> +       if (!value)
> +               return replace_with_pseudo(insn, pseudo);
> +       switch (def_opcode(insn->src1)) {
> +       case OP_AND:
> +               // replace (A & M) >> S
> +               // by      (A >> S) & (M >> S)

Why (A>>S) & (M >>S) is easier to simplify?

The original has two instruction but the result has three.

Is that that because A>>S is more likely to find match in
the CSE?

What if there is no match found, does that mean it is
not useful to do this transformation?

Chris
