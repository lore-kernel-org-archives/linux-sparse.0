From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] pending fixes for sparse's next release
Date: Thu, 4 May 2017 13:44:14 +0200
Message-ID: <20170504114413.yokqlmhxbhehgget@ltop.local>
References: <20170430034149.iltu3kctg6n7w4g2@macpro.local>
 <CANeU7QkKubmzFjfbSqN0aQ=rwo=XJKtM1BfDHrb3Z3Nuc=VkKw@mail.gmail.com>
 <20170503223020.43cj45t4smjhw6qc@desk.local>
 <CANeU7QkgH+Z=f5Lw_AY38J1UMuN4qL8cMOWBWZWR5hw0J78weg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35541 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932389AbdEDLoS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 07:44:18 -0400
Received: by mail-wr0-f177.google.com with SMTP id z52so6304837wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 04:44:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkgH+Z=f5Lw_AY38J1UMuN4qL8cMOWBWZWR5hw0J78weg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 03, 2017 at 09:37:17PM -0400, Christopher Li wrote:
> On Wed, May 3, 2017 at 6:30 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I see it as 'sparse-next-20170501' while 'sparse-next' contains
> > (a27c14511 "Add more declarations for more builtin functions").
> > Is it like this it should be?
> 
> Oh, no. Thanks for the catch.
> 
> I did not reset sparse-next properly. Let me redo it.

It's good now. Thanks.

I'll check if there is any pending fixes that should go in.
I think there may be two that should but important ones are
already in now.

Is there anything else than fixes that you would like to see
in the coming release?

Maybe you can already 'promote' to master the previous -next
(14964df53 "avoid crash with test-linearize -vv")?

-- Luc
