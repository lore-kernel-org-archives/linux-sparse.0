From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Handle SForced in storage_modifiers
Date: Mon, 14 Nov 2016 12:17:47 -0800
Message-ID: <CA+55aFxbn+ZAyN9zzcEF60UPoRN2hq86LHk9v5ecqg-c+x3pNw@mail.gmail.com>
References: <1479150736-28392-1-git-send-email-jlayton@redhat.com> <20161114200447.GA15866@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34128 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938706AbcKNURt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Nov 2016 15:17:49 -0500
Received: by mail-yw0-f195.google.com with SMTP id a10so8790865ywa.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Nov 2016 12:17:49 -0800 (PST)
In-Reply-To: <20161114200447.GA15866@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 14, 2016 at 12:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> The array is statically initialized and never modified,
> your patch shouldn't change anything, and this regardless of
> the memory layout or compiler options.

The problem is the _size_ of the array. Without that initializer for
SForced case, it is one entry too small, and you get a random access
past the end of the array.

The patch is definitely correct.

              Linus
