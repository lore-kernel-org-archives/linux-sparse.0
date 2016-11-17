From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] By default disable '-Wunknown-attribute'
Date: Fri, 18 Nov 2016 00:52:37 +0800
Message-ID: <CANeU7QnpsYS-YwSgqw8tiKO7FUFxjrRbKUoA8bb-gTsjK-YVvA@mail.gmail.com>
References: <20161102215939.36765-1-luc.vanoostenryck@gmail.com> <20161102215939.36765-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32965 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754629AbcKQRHm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:07:42 -0500
Received: by mail-it0-f65.google.com with SMTP id c20so16448284itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:07:41 -0800 (PST)
In-Reply-To: <20161102215939.36765-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 5:59 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Generally, we won't be interested by the warnings from this flag,
> but we can always explicitly ask for them if needed.

I don't want to disable it by default. I think default should be on so
that we can collect test case and prepare to add them later one.

I would much rather see a patch to make those attribute parsed
eventually. I think gcc or clang should have a collection of all
the attribute stash some where. I haven't take a closer look myself.

Most of the attribute are trivial to parse correctly. We should have
some thing like empty_int_attribute instead of blindly ignore them.

Also ideally the attribute should be a list instead of member in the
ctype structure. Most of the symbol has at most one attribute any
way. That is a much bigger change though.

Chris
