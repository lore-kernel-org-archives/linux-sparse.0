From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 02:58:45 -0700
Message-ID: <CANeU7Q=K2eVq8v=jFE1HwEJHpNP8i4bG7FkgtBqFqF_-Zmopdg@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local> <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
 <CACXZuxfoPyT65p46wZBN8=FMEgTwCeh3Y2P3Rc5KbYO39OK_xg@mail.gmail.com>
 <CACXZuxeN2E5TCvof+7N0iFwZpULePf3E7V=0-+kUTrNURV2tvw@mail.gmail.com>
 <20170707093831.37mnz572mayodfip@ltop.local> <CACXZuxdwFQu_PnppN0C19M2icbhoPSo5TcYq+Ezt7OvMK+tzhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36712 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdGGJ6q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:58:46 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so14896398pgb.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:58:46 -0700 (PDT)
In-Reply-To: <CACXZuxdwFQu_PnppN0C19M2icbhoPSo5TcYq+Ezt7OvMK+tzhA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 7, 2017 at 2:41 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Well I think it is best not to do that really. Why do the nodes need
> to be deleted? There is no harm in retaining them surely as long as
> the the iterators can handle it?
>
Please know that, even the node is not deleted. Just remove the
entry from list->list[] will cause problem on the outer loop on the same
list, if there is one.

Chris
