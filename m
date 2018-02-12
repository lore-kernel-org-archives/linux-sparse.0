From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/9] add helpers for pseudo's user-list's size
Date: Mon, 12 Feb 2018 14:11:34 -0800
Message-ID: <CA+55aFzwX8CKAeDuTwVg3MKa+LHXNaphi+mqoZE+2C7gaG61wg@mail.gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com> <20180212220246.17750-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:54806 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932454AbeBLWLf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:11:35 -0500
Received: by mail-it0-f47.google.com with SMTP id k131so8668283ith.4
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:11:35 -0800 (PST)
In-Reply-To: <20180212220246.17750-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Feb 12, 2018 at 2:02 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Also add has_user(), a wrapper around the above that
> can directly be used on a pseudo.

You add that wrapper, but then:

> -       if (ptr_list_size((struct ptr_list *) *list) == 0)
> +       if (pseudo_user_list_size(*list) == 0)

you don't actually *use* it. That seems pointless.

                Linus
