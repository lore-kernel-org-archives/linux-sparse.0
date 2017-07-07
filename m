From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 11:38:32 +0200
Message-ID: <20170707093831.37mnz572mayodfip@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local>
 <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
 <CACXZuxfoPyT65p46wZBN8=FMEgTwCeh3Y2P3Rc5KbYO39OK_xg@mail.gmail.com>
 <CACXZuxeN2E5TCvof+7N0iFwZpULePf3E7V=0-+kUTrNURV2tvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34316 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdGGJif (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:38:35 -0400
Received: by mail-wr0-f170.google.com with SMTP id 77so38834807wrb.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:38:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxeN2E5TCvof+7N0iFwZpULePf3E7V=0-+kUTrNURV2tvw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 07, 2017 at 10:26:38AM +0100, Dibyendu Majumdar wrote:
> In general though - while a list is being traversed, deleting items
> should be expected to work, as long as a ptrlist node is not deleted.
> The reason is that an iterator is presumably on a particular node -
> and if unknown to if the node it is on is deleted, then the iterator
> has no way to
> continue. So maybe calling pack in the middle of an operation is
> causing the problem?
> 
> I think the current implementation (and my version too) is safe as
> long as nodes are not deleted while a traversal is going on?

Yes, but the problem is that we do delete nodes while another traversal
is going on. And this can be very indirect.

-- Luc 
