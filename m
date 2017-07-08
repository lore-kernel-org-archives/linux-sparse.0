From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 01/34] ptrlist: simplify DO_FOR_EACH/DO_END_FOR_EACH
Date: Sat, 8 Jul 2017 08:31:08 -0700
Message-ID: <CANeU7QmLTr0Zvh19KPK_rf1Vw8-dVeuYJThAqo6bmixK+ZnoUw@mail.gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com> <20170707134002.49500-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35166 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbdGHPbJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Jul 2017 11:31:09 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so30179729pfk.2
        for <linux-sparse@vger.kernel.org>; Sat, 08 Jul 2017 08:31:09 -0700 (PDT)
In-Reply-To: <20170707134002.49500-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 7, 2017 at 6:39 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> -       if (__head) {                                                                   \
> -               do { int __nr;                                                          \
> -                       for (__nr = 0; __nr < __list->nr; __nr++) {                     \
> -                               do {                                                    \
> -                                       ptr = PTR_ENTRY(__list,__nr);                   \
> -                                       do {
> +       if (!__head) break;                                                             \
> +       do { int __nr;                                                                  \
> +               for (__nr = 0; __nr < __list->nr; __nr++) {                             \
> +                       ptr = PTR_ENTRY(__list,__nr);                                   \
>
>  #define DO_END_FOR_EACH(ptr, __head, __list, __nr)                                     \
> -                                       } while (0);                                    \
> -                               } while (0);                                            \
> -                       }                                                               \
> -               } while ((__list = __list->next) != __head);                            \
> -       }                                                                               \
> +               }                                                                       \
> +       } while ((__list = __list->next) != __head);                                    \
>  } while (0)

I think the extra "do {} while (0)" is there to prevent the FOR_EACH
paring with END_FOR_EACH_REVERSE() and vise versa.

Chris
