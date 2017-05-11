From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] FS: Fixing return type of unsigned_offsets
Date: Thu, 11 May 2017 22:09:19 +0200
Message-ID: <CAExDi1SJbkuabX7j1Fe6wO3k=3VS8iswXq-MjtWidM5=YkStYg@mail.gmail.com>
References: <1494476871-26474-1-git-send-email-pushkar.iit@gmail.com>
 <1494477592.2028.7.camel@perches.com> <CAMvNc9AsahXxFsYo91VoW-YLLk9=BFE9j1BK-Bkm_ZQrvsS67w@mail.gmail.com>
 <1494478535.2028.9.camel@perches.com> <CAMvNc9AKzs82zaHq1z+gAfsSu90PS_9N+L3VDEMdYDK0PbhA2A@mail.gmail.com>
 <20170511060744.GJ390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33278 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdEKUJV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 16:09:21 -0400
In-Reply-To: <20170511060744.GJ390@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Pushkar Jambhlekar <pushkar.iit@gmail.com>, Joe Perches <joe@perches.com>, linux-fsdevel@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 11, 2017 at 8:07 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> FVO"needed" equal to "needed to make sparse STFU"?  If anything, that's
> sparse being wrong - evaluate.c:check_assignment_type() should do
>                 if (t == &ctype_bool) {
>                         if (is_fouled_type(s))
>                                 warning((*rp)->pos, "%s degrades to integer",
>                                         show_typename(s->ctype.base_type));
>                         goto Cast;
>                 }
> right after
>                 } else if (!(sclass & TYPE_RESTRICT))
>                         goto Cast;

What about an explicit cast of restricted types to bool?
I think we would want the equivalent of this patch for those too.

-- Luc
