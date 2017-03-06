From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 05/13] add get_nth1_arg()
Date: Mon, 6 Mar 2017 22:40:17 +0800
Message-ID: <CANeU7Qma7hJQeLjc83aXR-cNGA3w7Z4cQDYFstK3PrUWUfZDaw@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com> <20170305112047.3411-6-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37489 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753746AbdCFOrE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 09:47:04 -0500
Received: by mail-it0-f51.google.com with SMTP id 203so51253970ith.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 06:47:03 -0800 (PST)
In-Reply-To: <20170305112047.3411-6-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> A backend may need to know the size or the type of an
> argument and there is no easy way to access to this info.

Actually, there is a way to do it with two list iterative. Will comment
it on the next patch that use the get_nth1_arg().


> +static inline struct symbol *get_nth1_arg(struct symbol *fn, int idx)
> +{
> +       struct symbol_list *args = fn->ctype.base_type->arguments;
> +       struct symbol *arg;
> +       int i = 0;
> +       FOR_EACH_PTR(args, arg) {
> +               if (++i == idx)
> +                       return arg;
> +       } END_FOR_EACH_PTR(arg);
> +
> +       return NULL;

As I said, I am not sure this is necessary in the particular case.
However, the nth list entry is some what useful. If we add that,
we should add it to ptrlist.c. Then every time of ptr_list can have it.

Also, there is no need to do "++i", it should use the list->nr to skip
over the list node for the case where n is relative large. Then only do the
counting inside the list node. If list is packed, it is every easier, we can
just return from the index. Depend on we want to allow unpacked list
or not.

Chris
