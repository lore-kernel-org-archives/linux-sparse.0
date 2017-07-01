From: Lance Richardson <lrichard@redhat.com>
Subject: Re: Sparse release v0.5.1 RC3
Date: Sat, 1 Jul 2017 16:37:27 -0400 (EDT)
Message-ID: <905534368.29108867.1498941447093.JavaMail.zimbra@redhat.com>
References: <CANeU7Q=q8PVxavt1CegVebT9aSnQ2ugXrE4PStf7ey08Kg+NpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbdGAUh2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 16:37:28 -0400
In-Reply-To: <CANeU7Q=q8PVxavt1CegVebT9aSnQ2ugXrE4PStf7ey08Kg+NpA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

> From: "Christopher Li" <sparse@chrisli.org>
> To: "Linux-Sparse" <linux-sparse@vger.kernel.org>
> Cc: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>, "Lance Richardson" <lrichard@redhat.com>
> Sent: Thursday, 29 June, 2017 9:30:34 PM
> Subject: Sparse release v0.5.1 RC3
> 
> I have update the master on sparse git repository to
> RC3. We actually skip the RC2 on this release.
> 
> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/
> 
> Compare to RC1, most noticeably fix some "crazy programmer"
> error on compiling git source code. Thanks Luc for contribute
> most of the patches from RC1.
> 
> Again, please give it a good test. Report back what issue
> you might find. If there is no big issue, I plan to tag the finial version
> of v0.5.1 next week.
> 
> Chris
> 

Hi Chris,

I've tried it against davem's net repository and openvswitch master under
Fedora 25 x86_64, looks good!

Thanks,

   Lance
