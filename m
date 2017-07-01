From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse release v0.5.1 RC3
Date: Sat, 1 Jul 2017 22:45:56 +0200
Message-ID: <20170701204555.vkpl4fsvudsoot6y@ltop.local>
References: <CANeU7Q=q8PVxavt1CegVebT9aSnQ2ugXrE4PStf7ey08Kg+NpA@mail.gmail.com>
 <905534368.29108867.1498941447093.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35938 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdGAUqA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 16:46:00 -0400
Received: by mail-wm0-f46.google.com with SMTP id 62so136991931wmw.1
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 13:46:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <905534368.29108867.1498941447093.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 01, 2017 at 04:37:27PM -0400, Lance Richardson wrote:
> > From: "Christopher Li" <sparse@chrisli.org>
> > To: "Linux-Sparse" <linux-sparse@vger.kernel.org>
> > Cc: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>, "Lance Richardson" <lrichard@redhat.com>
> > Sent: Thursday, 29 June, 2017 9:30:34 PM
> > Subject: Sparse release v0.5.1 RC3
> > 
> > I have update the master on sparse git repository to
> > RC3. We actually skip the RC2 on this release.
> > 
> > https://git.kernel.org/pub/scm/devel/sparse/sparse.git/
> > 
> > Compare to RC1, most noticeably fix some "crazy programmer"
> > error on compiling git source code. Thanks Luc for contribute
> > most of the patches from RC1.
> > 
> > Again, please give it a good test. Report back what issue
> > you might find. If there is no big issue, I plan to tag the finial version
> > of v0.5.1 next week.
> > 
> > Chris
> > 
> 
> Hi Chris,
> 
> I've tried it against davem's net repository and openvswitch master under
> Fedora 25 x86_64, looks good!

Nice.
Thanks for the testing.

-- Luc 
