From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 0/5] fix list corruption with recursive remove_usage()
Date: Sat, 5 Aug 2017 10:55:19 +0200
Message-ID: <CAExDi1Rv17E=RwZwhZQKKcsHtnnvz7cyuo1dGQG=eN-QaCDcfg@mail.gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
 <CAExDi1Ra9v5QXoP-oSRH6J7XFadMAO5BC79e0e9+-FMjvnwmNw@mail.gmail.com> <CANeU7QkKeP_eqCZkutog53zPiASQVOtMPzyRDPtP9ggAQyMuMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33430 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdHEIzU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 04:55:20 -0400
Received: by mail-qk0-f182.google.com with SMTP id a77so20114126qkb.0
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 01:55:20 -0700 (PDT)
In-Reply-To: <CANeU7QkKeP_eqCZkutog53zPiASQVOtMPzyRDPtP9ggAQyMuMA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 5, 2017 at 2:24 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 4, 2017 at 6:32 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Please ignore this one. I just resent a -v4.
>
> Your V4 include a git pull address right?

Yes, sure.
Why you're asking?

-- Luc
