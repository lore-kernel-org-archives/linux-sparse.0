From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Fri, 18 Nov 2016 02:17:14 +0800
Message-ID: <CANeU7QnqhZfZtToAhQ8CPniS7DFNdhwYdCp=zZDzsqtpuD=pJQ@mail.gmail.com>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com> <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36468 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941843AbcKQSRU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 13:17:20 -0500
Received: by mail-it0-f68.google.com with SMTP id n68so16869108itn.3
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 10:17:15 -0800 (PST)
In-Reply-To: <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Nov 18, 2016 at 1:40 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I suspect they should be fairly easy to update to just walk the list
> until they hit a non-empty case (like DO_NEXT() already does, for
> example).

I think you are right, as always. It just need to add four while loops
into first_ptr_list/last_ptr_list/DO_PREPARE/DO_RESET.

Amount those 3 of the place should be able to share a function
(or macro) to find the next not empty entry from list head.

Ptrlist deletion happen so rare, it does not justify the complexity.

Luc, sorry about the bad suggestion.

Chris
