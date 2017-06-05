From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/3] memcpy()'s byte count is unsigned
Date: Tue, 6 Jun 2017 00:16:16 +0200
Message-ID: <CAMHZB6GFaf+zL1MtO65oYKYnLZ+2mto=Kn0o5e3jZtA0a4tDYg@mail.gmail.com>
References: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
 <20170603074727.66945-2-luc.vanoostenryck@gmail.com> <CANeU7QmDHd4mZNZyaYVvJ0LPykUNbH3H1TEELZhYYDp=Ob_sMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32863 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEWQS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 18:16:18 -0400
Received: by mail-qt0-f194.google.com with SMTP id w1so19423721qtg.0
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 15:16:18 -0700 (PDT)
In-Reply-To: <CANeU7QmDHd4mZNZyaYVvJ0LPykUNbH3H1TEELZhYYDp=Ob_sMg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

On Mon, Jun 5, 2017 at 10:52 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Jun 3, 2017 at 12:47 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> The checker part of sparse does some checking on memcpy(),
>> memset(), copy_{from,to}_user() byte count and warn if the
>> value is known to be too large. The comparison is done with
>> signed numbers and it also warns if the value is negative.
>
>
> I see you have the V1 in git tree in the 0/3 email.
>
> Do you have the V2 in the git tree some where as well?
> I can't seem to find the V2 version of the 0/3 email.

Ah, sorry, I've cut-&-pasted the cover letter between V1 & V2
and thus removed the 'v2' from the title.

The mail corresponding to V2's cover letter is:
    http://marc.info/?l=linux-sparse&m=149647605600827&w=4
but I'll resent it as a reply to this mail.

-- Luc
