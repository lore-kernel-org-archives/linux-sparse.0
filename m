From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 0/5] fix list corruption with recursive remove_usage()
Date: Sun, 6 Aug 2017 03:07:58 +0200
Message-ID: <CAMHZB6FoEidThM+jz2FQuEuTwRUha3-uvUyEDVy2tetXBANmRg@mail.gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
 <CAExDi1Ra9v5QXoP-oSRH6J7XFadMAO5BC79e0e9+-FMjvnwmNw@mail.gmail.com>
 <CANeU7QkKeP_eqCZkutog53zPiASQVOtMPzyRDPtP9ggAQyMuMA@mail.gmail.com>
 <CAExDi1Rv17E=RwZwhZQKKcsHtnnvz7cyuo1dGQG=eN-QaCDcfg@mail.gmail.com>
 <CANeU7Q=oU74sTOgrZNSwowwRUUV=L7AecU8iUkA6jjER_j6QOQ@mail.gmail.com>
 <CAExDi1QLDZ0J0_HPOzQy+aAR78h8j1KdeN+p+Za0XCrb_VSRpw@mail.gmail.com> <CANeU7QnZQqqxwJ=UjeVa4WunHjwFFdc3KBaAZriwesZXbxo8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35608 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdHFBH7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 21:07:59 -0400
Received: by mail-qt0-f195.google.com with SMTP id t37so4910469qtg.2
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 18:07:59 -0700 (PDT)
In-Reply-To: <CANeU7QnZQqqxwJ=UjeVa4WunHjwFFdc3KBaAZriwesZXbxo8kA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 2:09 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Aug 5, 2017 at 7:04 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> No I only forgot to change [PATCH v3 0/5] into [PATCH v4 0/5] while copy pasting
>> the cover letter.
>>
>> cfr: http://marc.info/?l=linux-sparse&m=150188507213269&w=4
>>
>
> Do you think I need adjustment or the current version on sparse-next
> is fine? I already rebase to master.

No no. It's fine so.

> The base of your branch is not fast forward to master.

Yes, my branches often don't if there are some other patches but
the branching point is usually quite recent and the merge trivial.

-- Luc
