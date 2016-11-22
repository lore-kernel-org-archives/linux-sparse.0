From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Tue, 22 Nov 2016 19:13:11 +0800
Message-ID: <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com> <1479721551.8662.10.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33206 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932932AbcKVLNN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 06:13:13 -0500
Received: by mail-io0-f172.google.com with SMTP id j65so64533018iof.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 03:13:13 -0800 (PST)
In-Reply-To: <1479721551.8662.10.camel@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 21, 2016 at 5:45 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Yes, that'd make some sense. I have no idea how to pull it off though

I take a brief look.

It seems that you need to implement a symbol with ".expand" implement as
"expand_bswap", similar to "expand_constant_p".

Later in in "eval_init_table", just add one entry for __builtin_bswap.
eval_init_table[] = {
{ "__builtin_constant_p", &builtin_fn_type, MOD_TOPLEVEL, &constant_p_op },
{ "__builtin_safe_p", &builtin_fn_type, MOD_TOPLEVEL, &safe_p_op },
{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
{ NULL, NULL, 0 }
};

As you can see in "expand_call", the cost of arguments is zero
if all arguments are constant.

The function "expand_symbol_call" even have the comment about expanding
the builtins there.

In side the "expand_bswap", it should abort if cost is not zero.
It means arguments are not constant, this expression can't
expand into a constant value.

Otherwise, expand_bswap should proceed to calculate the return
value of the bswap call and rewrite the call expression into a constant.
Some what similar to the "__builtin_constant_p".

I will see if I can hack up some thing very quick.

Chris
