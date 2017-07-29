From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] pre-process: replace use of vla's with heap
 allocation
Date: Sat, 29 Jul 2017 18:22:36 +0200
Message-ID: <20170729162235.kt7ernrjliju6n2f@ltop.local>
References: <5ffb141e-fdb2-a1b8-a5b7-c922d1a9ef08@ramsayjones.plus.com>
 <CANeU7QkmtVVPhhanR2M7=3P9cCse0B9rXJSfx8c1NCC4aHZ-qw@mail.gmail.com>
 <cce05c3f-a309-9fa7-3107-e6e6831972aa@ramsayjones.plus.com>
 <CAExDi1S_mQRHQmAOOhdctbJOgLCo0pArXO6_QKY2WaNMsb9Y0Q@mail.gmail.com>
 <CANeU7Q=eCq6Ndxsq8GnVNb7J=MYD=3vHjBf1R1miLPbyWkXYxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35365 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbdG2QWj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 12:22:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id m85so43606530wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 09:22:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=eCq6Ndxsq8GnVNb7J=MYD=3vHjBf1R1miLPbyWkXYxg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 29, 2017 at 12:16:53PM -0400, Christopher Li wrote:
> On Sat, Jul 29, 2017 at 9:17 AM, Luc Van Oostenryck
> > Also, this is not IMO -rc4+ material.
> 
> Agree, because it changes the code behavior. Do you mind have the '-Wno-vla'
> in -rc5? That should not change any code it generate. I am fine either way.

I don't mind.

-- Luc
