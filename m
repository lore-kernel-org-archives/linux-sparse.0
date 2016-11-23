From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Wed, 23 Nov 2016 22:30:35 +0800
Message-ID: <CANeU7Qm99Zv9D16nbELUeOPyHvwYme0TOVDPTg_=S6sWFK3Z7g@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net> <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local> <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <1479882507.4432.1.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34958 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936436AbcKWOaq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 09:30:46 -0500
Received: by mail-oi0-f51.google.com with SMTP id b126so16025952oia.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 06:30:41 -0800 (PST)
In-Reply-To: <1479882507.4432.1.camel@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Wed, Nov 23, 2016 at 2:28 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Just a small comment:
>
>> +       if (expression_list_size(args) != 1) {
>> +               sparse_error(expr->pos, "not enough arguments for function %s",
>> +                               show_ident(sym->ident));
>
> Should that say "invalid number of arguments (expected 1)" or so?
>

Right, that is better.

Chris
