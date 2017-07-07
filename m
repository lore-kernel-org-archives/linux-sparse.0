From: Christopher Li <sparse@chrisli.org>
Subject: Git url for the ptrlist checking branch Was: Re: [PATCH 1/5] do not
 corrupt ptrlist
Date: Thu, 6 Jul 2017 23:43:32 -0700
Message-ID: <CANeU7QmLZiAu1AZCCN3BSA3=V4mpwdyQ6qGDWipXE-eJEfVuCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36759 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdGGGnd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 02:43:33 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so12517550pgb.3
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 23:43:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 11:27 PM, Christopher Li <sparse@chrisli.org> wrote:
> Thanks for the help. Yes, that is exactly the bug I am talking about.
> Deleting list entry while the parent is still looping on it.
> Sparse ptrlist currently has very subtle bug on this situation.

The git repo for the checking patch. I did not signed off that is on purpose.
It is not final.

make check will fail horribly on this right now.

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=check-ptrlist-inner-delete

Chris
