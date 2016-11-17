From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Thu, 17 Nov 2016 09:40:20 -0800
Message-ID: <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38118 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754980AbcKQRkW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:40:22 -0500
Received: by mail-it0-f44.google.com with SMTP id j191so65344906ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:40:21 -0800 (PST)
In-Reply-To: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Thu, Nov 17, 2016 at 9:25 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The macros that do the ptrlist walking don't handle empty blocks.

Actually, most of the_do_ handle empty blocks. In particular, the
normal FOR_EACH_PTR() case should handle it just fine.

The exception is, I think:

 - first_ptr_list/last_ptr_list

 - DO_PREPARE/DO_RESET

which just don't walk the pointer block list, they just end up blindly doing

        PTR_ENTRY(list, 0);

for the first entry, or

        list = list->prev;
        PTR_ENTRY(list, list->nr-1);

for the last one.

I suspect they should be fairly easy to update to just walk the list
until they hit a non-empty case (like DO_NEXT() already does, for
example).

              Linus
