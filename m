From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 0/5] fix list corruption with recursive remove_usage()
Date: Sat, 5 Aug 2017 20:09:22 -0400
Message-ID: <CANeU7QnZQqqxwJ=UjeVa4WunHjwFFdc3KBaAZriwesZXbxo8kA@mail.gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
 <CAExDi1Ra9v5QXoP-oSRH6J7XFadMAO5BC79e0e9+-FMjvnwmNw@mail.gmail.com>
 <CANeU7QkKeP_eqCZkutog53zPiASQVOtMPzyRDPtP9ggAQyMuMA@mail.gmail.com>
 <CAExDi1Rv17E=RwZwhZQKKcsHtnnvz7cyuo1dGQG=eN-QaCDcfg@mail.gmail.com>
 <CANeU7Q=oU74sTOgrZNSwowwRUUV=L7AecU8iUkA6jjER_j6QOQ@mail.gmail.com> <CAExDi1QLDZ0J0_HPOzQy+aAR78h8j1KdeN+p+Za0XCrb_VSRpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34257 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbdHFAJX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 20:09:23 -0400
Received: by mail-pg0-f41.google.com with SMTP id u185so20914087pgb.1
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 17:09:23 -0700 (PDT)
In-Reply-To: <CAExDi1QLDZ0J0_HPOzQy+aAR78h8j1KdeN+p+Za0XCrb_VSRpw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 5, 2017 at 7:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> No I only forgot to change [PATCH v3 0/5] into [PATCH v4 0/5] while copy pasting
> the cover letter.
>
> cfr: http://marc.info/?l=linux-sparse&m=150188507213269&w=4
>

Do you think I need adjustment or the current version on sparse-next
is fine? I already rebase to master.

The base of your branch is not fast forward to master.

Chris
